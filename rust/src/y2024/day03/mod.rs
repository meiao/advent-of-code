use regex::Regex;

fn part1(input: Vec<&str>) -> u64 {
    let re = Regex::new(r"mul\([0-9]{1,3},[0-9]{1,3}\)").unwrap();
    let cmds = process_input(input, re);
    execute(cmds)
}

fn part2(input: Vec<&str>) -> u64 {
    let re = Regex::new(r"(mul\([0-9]{1,3},[0-9]{1,3}\))|(do\(\))|(don't\(\))").unwrap();
    let cmds = process_input(input, re);
    execute(cmds)
}

fn process_input(input: Vec<&str>, re: Regex) -> Vec<&str> {
    input
        .iter()
        .map(|line| re.find_iter(line))
        .flatten()
        .map(|re_match| re_match.as_str())
        .collect::<Vec<&str>>()
}

/// assumes all items in input are either do(); don't(); or a valid mul(x,y)
fn execute(input: Vec<&str>) -> u64 {
    let mut enabled = true;
    let mut sum = 0;
    input.iter().for_each(|cmd| {
        if *cmd == "do()" {
            enabled = true;
        } else if *cmd == "don't()" {
            enabled = false;
        } else if enabled {
            // at this point, cmd is a mul(x,y), only process if enabled
            sum += execute_mul(cmd)
        }
    });
    sum
}

fn execute_mul(mul: &str) -> u64 {
    mul
        .get(4..(mul.len() - 1)) // keep only x,y
        .unwrap()
        .split(",")
        .map(&str::parse::<u64>)
        .map(Result::unwrap)
        .reduce(|acc, num| acc * num)
        .unwrap()
}

#[cfg(test)]
mod test;
