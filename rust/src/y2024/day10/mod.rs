use crate::utils::{Finder, Grid};
use itertools::Itertools;

fn part1(input: Vec<&str>) -> u64 {
    let finder = Finder::create(&input);
    let trail_heads = finder
        .find("0")
        .iter()
        .map(|vec| vec.origin)
        .collect::<Vec<[usize; 2]>>();
    let grid = finder.grid();
    trail_heads
        .into_iter()
        .map(|trail_head| trail_ends(&grid, trail_head))
        .flatten()
        .count() as u64
}

fn trail_ends(grid: &Grid, head: [usize; 2]) -> Vec<[usize; 2]> {
    if let Some(char) = grid.char_at(&head) {
        if char == '9' {
            return vec![head];
        }

        let next_char = next_char(char);
        let next_points = next_points(head);
        next_points
            .into_iter()
            .flat_map(|pos| {
                if grid.char_at(&pos) == Some(next_char) {
                    trail_ends(grid, pos)
                } else {
                    vec![]
                }
            })
            .unique()
            .collect()
    } else {
        vec![]
    }
}

fn next_char(c: char) -> char {
    (c as u8 + 1) as char
}

fn next_points(head: [usize; 2]) -> Vec<[usize; 2]> {
    let mut next_dirs = vec![];
    next_dirs.push([head[0] + 1, head[1]]);
    next_dirs.push([head[0], head[1] + 1]);
    if head[0] > 0 {
        next_dirs.push([head[0] - 1, head[1]]);
    }
    if head[1] > 0 {
        next_dirs.push([head[0], head[1] - 1]);
    }
    next_dirs
}

fn part2(input: Vec<&str>) -> u64 {
    let finder = Finder::create(&input);
    let trail_heads = finder
        .find("0")
        .iter()
        .map(|vec| vec.origin)
        .collect::<Vec<[usize; 2]>>();
    let grid = finder.grid();
    trail_heads
        .into_iter()
        .map(|trail_head| trail_score(&grid, trail_head))
        .sum::<u64>()
}

fn trail_score(grid: &Grid, head: [usize; 2]) -> u64 {
    if let Some(char) = grid.char_at(&head) {
        if char == '9' {
            return 1;
        }

        let next_char = next_char(char);
        let next_points = next_points(head);
        next_points
            .into_iter()
            .map(|pos| {
                if grid.char_at(&pos) == Some(next_char) {
                    trail_score(grid, pos)
                } else {
                    0
                }
            })
            .sum()
    } else {
        0
    }
}

#[cfg(test)]
mod test;
