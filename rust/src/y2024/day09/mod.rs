use itertools::Itertools;
use std::collections::HashMap;

fn part1(input: &str) -> u64 {
    // variables could have been smaller than usize, but usize prevents
    let mut disk_map = input
        .chars()
        .map(|c| c.to_digit(10).unwrap() as u64)
        .collect::<Vec<u64>>();
    let mut i: usize = 1;
    let mut memory_position = disk_map[0];
    let mut checksum: u64 = 0;
    if disk_map.len() % 2 == 0 {
        disk_map.pop(); // removing last free space
    }

    while i < disk_map.len() {
        if disk_map[i] == 0 {
            i += 1;
        } else if i % 2 == 0 {
            let file_size = disk_map[i];
            let file_id = i as u64 / 2;
            checksum += file_checksum(file_id, memory_position, file_size);
            memory_position += file_size;
            i += 1;
        } else {
            let free_size = disk_map[i];
            let last_element = disk_map.len() - 1;
            let last_file_size = disk_map[last_element];
            let file_id = disk_map.len() as u64 / 2;
            if free_size == last_file_size {
                checksum += file_checksum(file_id, memory_position, free_size);
                memory_position += free_size;
                disk_map.pop();
                disk_map.pop();
                i += 1;
            } else if free_size < last_file_size {
                checksum += file_checksum(file_id, memory_position, free_size);
                memory_position += free_size;
                disk_map[last_element] = last_file_size - free_size;
                i += 1;
            } else {
                // free_size > last_file_size
                checksum += file_checksum(file_id, memory_position, last_file_size);
                memory_position += last_file_size;
                disk_map.pop();
                disk_map.pop();
                disk_map[i] = free_size - last_file_size;
            }
        }
    }
    checksum
}

fn file_checksum(file_id: u64, memory_position: u64, size: u64) -> u64 {
    // file_id * (memory_pos + memory_pos + 1 + memory_pos + 2...)
    file_id * ((memory_position * size) + (size - 1) * size / 2)
}

fn part2(input: &str) -> u64 {
    let disk_map = input
        .chars()
        .map(|c| c.to_digit(10).unwrap() as u64)
        .collect::<Vec<u64>>();

    let mut files: Vec<FileInfo> = vec![];
    let mut free_space: HashMap<u64, u64> = HashMap::new();
    let mut memory_position = 0;

    for i in 0..disk_map.len() {
        let size = disk_map[i];
        if i % 2 == 0 {
            files.push(FileInfo {
                start_pos: memory_position,
                size,
            })
        } else {
            free_space.insert(memory_position, size);
        }
        memory_position += size;
    }

    let mut checksum = 0;
    for file_id in (1..files.len()).rev() {
        let file = &files[file_id];
        if let Some(new_pos) = new_position(&free_space, file) {
            let free_size = free_space[&new_pos];
            if file.size < free_size {
                free_space.insert(new_pos + file.size, free_size - file.size);
            }
            free_space.remove(&new_pos);
            checksum += file_checksum(file_id as u64, new_pos, file.size);
        } else {
            checksum += file_checksum(file_id as u64, file.start_pos, file.size)
        }
    }
    checksum
}

fn new_position(free_space: &HashMap<u64, u64>, file_info: &FileInfo) -> Option<u64> {
    for key in free_space.keys().sorted() {
        if key > &file_info.start_pos {
            return None;
        }
        let free_size = free_space[key];
        if free_size >= file_info.size {
            return Some(*key);
        }
    }
    None
}

struct FileInfo {
    start_pos: u64,
    size: u64,
}

#[cfg(test)]
mod test;
