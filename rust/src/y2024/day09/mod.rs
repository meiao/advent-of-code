fn part1(input: &str) -> usize {
    // variables could have been smaller than usize, but usize prevents
    let mut disk_map = input
        .chars()
        .map(|c| c.to_digit(10).unwrap() as usize)
        .collect::<Vec<usize>>();
    let mut memory: Vec<usize> = vec![];
    let mut i: usize = 0;
    if disk_map.len() % 2 == 0 {
        disk_map.pop(); // removing last free space
    }

    while i < disk_map.len() {
        if i % 2 == 0 {
            let file_size = disk_map[i];
            let file_id = i / 2;
            push(&mut memory, file_id, file_size);
            i += 1;
        } else {
            let free_size = disk_map[i];
            let last_element = disk_map.len() - 1;
            let last_file_size = disk_map[last_element];
            let file_id = disk_map.len() / 2;
            if free_size == last_file_size {
                push(&mut memory, file_id, free_size);
                disk_map.pop();
                disk_map.pop();
                i += 1;
            } else if free_size < last_file_size {
                push(&mut memory, file_id, free_size);
                disk_map[last_element] = last_file_size - free_size;
                i += 1;
            } else {
                // free_size > last_file_size
                push(&mut memory, file_id, last_file_size);
                disk_map.pop();
                disk_map.pop();
                disk_map[i] = free_size - last_file_size;
            }
        }
    }

    memory
        .iter()
        .enumerate()
        .map(|(i, file_id)| i * file_id)
        .sum()
}

fn push(memory: &mut Vec<usize>, file_id: usize, times: usize) {
    for _ in 0..times {
        memory.push(file_id);
    }
}

fn part2(input: &str) -> i64 {
    0
}

#[cfg(test)]
mod test;
