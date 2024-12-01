use std::collections::HashMap;

fn part1(input: Vec<&str>) -> i64 {
    let mut list1: Vec<i64> = vec![];
    let mut list2: Vec<i64> = vec![];
    for line in input.iter() {
        let numbers: Vec<i64> = line
            .split("   ")
            .map(&str::parse::<i64>)
            .map(Result::unwrap)
            .collect();

        list1.push(numbers[0]);
        list2.push(numbers[1]);
    }
    list1.sort();
    list2.sort();
    let mut sum = 0;
    for i in 0..list1.len() {
        sum += (list1[i] - list2[i]).abs();
    }
    sum
}

fn part2(input: Vec<&str>) -> u64 {
    let mut keys: Vec<u64> = vec![];
    let mut count_map: HashMap<u64, u64> = HashMap::new();
    for line in input.iter() {
        let numbers: Vec<u64> = line
            .split("   ")
            .map(&str::parse::<u64>)
            .map(Result::unwrap)
            .collect();
        keys.push(numbers[0]);
        if let Some(count) = count_map.get(&numbers[1]) {
            count_map.insert(numbers[1], *count + 1);
        } else {
            count_map.insert(numbers[1], 1);
        }
    }
    keys.iter().map(|key| calc(key, &count_map)).sum()
}

fn calc(key: &u64, count_map: &HashMap<u64, u64>) -> u64 {
    if let Some(count) = count_map.get(key) {
        *count * key
    } else {
        0
    }
}

#[cfg(test)]
mod test;
