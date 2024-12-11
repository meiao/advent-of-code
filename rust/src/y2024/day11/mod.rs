use std::collections::HashMap;
use std::iter::successors;

fn solve(input: &str, repetitions: u8) -> u64 {
    let mut num_count: HashMap<u64, u64> = HashMap::new();
    input
        .split(' ')
        .map(&str::parse::<u64>)
        .map(Result::unwrap)
        .for_each(|num| {
            num_count.insert(num, 1);
        });

    for _ in 0..repetitions {
        num_count = iterate(num_count);
    }
    num_count.values().sum()
}

fn iterate(num_count: HashMap<u64, u64>) -> HashMap<u64, u64> {
    let mut next_values: HashMap<u64, u64> = HashMap::new();
    for (num, count) in num_count {
        calculate_next(num).into_iter().for_each(|new_num| {
            let prev_value = next_values.remove(&new_num).or(Some(0u64)).unwrap();
            next_values.insert(new_num, count + prev_value);
        });
    }
    next_values
}

fn calculate_next(num: u64) -> Vec<u64> {
    let mut next_values: Vec<u64> = Vec::new();

    if num == 0 {
        next_values.push(1);
    } else {
        let digit_count = count_digits(num);
        if digit_count % 2 == 1 {
            next_values.push(num * 2024);
        } else {
            let divisor = 10u64.pow(digit_count / 2);
            next_values.push(num / divisor);
            next_values.push(num % divisor);
        }
    }
    next_values
}

fn count_digits(n: u64) -> u32 {
    successors(Some(n), |&n| (n >= 10).then(|| n / 10)).count() as u32
}

#[cfg(test)]
mod test;
