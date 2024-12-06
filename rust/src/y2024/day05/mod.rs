use std::collections::HashMap;

fn part1(rules: Vec<&str>, updates: Vec<&str>) -> i64 {
    let rules = parse_rules(rules);
    updates
        .iter()
        .map(|update| update.split(",").collect())
        .filter(|update| is_ordered(&update, &rules))
        .map(|update| update[update.len() / 2].parse::<i64>())
        .map(Result::unwrap)
        .sum()
}

fn part2(rules: Vec<&str>, updates: Vec<&str>) -> i64 {
    let rules = parse_rules(rules);
    updates
        .iter()
        .map(|update| update.split(",").collect())
        .filter(|update| !is_ordered(&update, &rules))
        .map(|update| quicksort(update, &rules))
        .map(|update| update[update.len() / 2].parse::<i64>())
        .map(Result::unwrap)
        .sum()
}

fn quicksort<'a>(mut update: Vec<&'a str>, rules: &HashMap<&str, Vec<&str>>) -> Vec<&'a str> {
    if update.len() < 2 {
        return update;
    }

    let pivot = update.pop().unwrap();
    if let Some(must_come_after) = rules.get(pivot) {
        let mut before: Vec<&str> = vec![];
        let mut after: Vec<&str> = vec![];
        update.iter().for_each(|page| {
            if must_come_after.contains(page) {
                after.push(page);
            } else {
                before.push(page);
            }
        });

        let mut ordered = quicksort(before, rules);
        ordered.push(pivot);
        ordered.append(&mut quicksort(after, rules));
        ordered
    } else {
        // there is nothing that must come after the pivot
        let mut ordered = quicksort(update, rules);
        ordered.push(pivot);
        ordered
    }
}

/// pages in values come after the page in the key
fn parse_rules(input: Vec<&str>) -> HashMap<&str, Vec<&str>> {
    let mut rules = HashMap::new();
    input.iter().for_each(|line| {
        let pages = line.split("|").collect::<Vec<&str>>();
        if pages.len() != 2 {
            panic!("Invalid input");
        }
        rules
            .entry(pages[0])
            .or_insert_with(|| Vec::new())
            .push(pages[1]);
    });
    rules
}

fn is_ordered(update: &Vec<&str>, rules: &HashMap<&str, Vec<&str>>) -> bool {
    for i in 1..update.len() {
        if let Some(must_come_after) = rules.get(update.get(i).unwrap()) {
            for j in 0..i {
                if must_come_after.contains(update.get(j).unwrap()) {
                    return false;
                }
            }
        }
    }
    true
}

#[cfg(test)]
mod test;
