fn part1(input: Vec<&str>) -> usize {
    input.iter().map(convert_line).filter(safe).count()
}

fn convert_line(line: &&str) -> Vec<i64> {
    line.split_whitespace()
        .map(&str::parse::<i64>)
        .map(Result::unwrap)
        .collect()
}

fn safe(levels: &Vec<i64>) -> bool {
    for i in 0..(levels.len() - 1) {
        let diff = levels[i] - levels[i + 1];
        if diff == 0 || diff.abs() > 3 {
            return false;
        }
    }

    if !levels.is_sorted() && !levels.is_sorted_by(|a,b| b <= a) {
        return false;
    }
    true
}

fn part2(input: Vec<&str>) -> usize {
    input.iter().map(convert_line).filter(safe2).count()
}

fn safe2(levels: &Vec<i64>) -> bool {
    if safe(levels) {
        return true;
    }
    for i in 0..(levels.len()) {
        let mut copy = levels.clone();
        copy.remove(i);
        if safe(&copy) {
            return true;
        }
    }
    false
}

#[cfg(test)]
mod test;
