fn part1(input: Vec<&str>) -> i64 {
    let ops = vec![
        // fmt is ugly without this
        |n1: i64, n2: i64| -> i64 { n1 * n2 },
        |n1: i64, n2: i64| -> i64 { n1 + n2 },
    ];
    // input.iter().map(|line| calculate(line, &ops)).sum()
    input
        .iter()
        .map(|line| ProblemData::new(line))
        .filter(|data| solvable(&ops, data, data.nums[0], 1))
        .map(|data| data.total)
        .sum()
}

fn part2(input: Vec<&str>) -> i64 {
    let ops = vec![
        |n1: i64, n2: i64| -> i64 { n1 * n2 },
        |n1: i64, n2: i64| -> i64 { concat(n1, n2) },
        |n1: i64, n2: i64| -> i64 { n1 + n2 },
    ];
    input
        .iter()
        .map(|line| ProblemData::new(line))
        .filter(|data| solvable(&ops, data, data.nums[0], 1))
        .map(|data| data.total)
        .sum()
}

fn solvable(ops: &Vec<fn(i64, i64) -> i64>, data: &ProblemData, acc: i64, i: usize) -> bool {
    if i == data.nums.len() {
        return acc == data.total;
    }
    if acc > data.total {
        return false;
    }

    ops.iter()
        .any(|op| solvable(ops, data, op(acc, data.nums[i]), i + 1))
}

fn concat(mut n1: i64, n2: i64) -> i64 {
    let mut copy = n2;
    // there is no '0's in the input, or else this code would break
    while copy > 0 {
        n1 *= 10;
        copy /= 10;
    }
    n1 + n2
}

struct ProblemData {
    total: i64,
    nums: Vec<i64>,
}

impl ProblemData {
    fn new(line: &str) -> Self {
        let split: Vec<&str> = line.split(':').collect();
        let total = split[0].parse::<i64>().unwrap();
        let nums: Vec<i64> = split[1][1..]
            .split(' ')
            .map(&str::parse::<i64>)
            .map(Result::unwrap)
            .collect();
        ProblemData { total, nums }
    }
}

#[cfg(test)]
mod test;
