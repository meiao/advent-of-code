use crate::utils::{Finder, Grid};
use std::collections::HashSet;

fn part1(input: Vec<&str>) -> i64 {
    let grid = Grid::create(&input);
    let start_point = Finder::create(&input).find("^").get(0).unwrap().origin;
    visited_positions(&grid, start_point).len() as i64
}

fn visited_positions(grid: &Grid, start_point: [usize; 2]) -> Vec<[usize; 2]> {
    let mut positions: HashSet<[usize; 2]> = HashSet::new();
    positions.insert(start_point);
    let mut dir = Direction::new();
    let mut position = start_point;
    loop {
        let next_position = dir.position(position);
        if next_position == None {
            break;
        }

        let next_position = next_position.unwrap();
        let next_char = grid.char_at(&next_position);
        if next_char == None {
            break;
        } else {
            let next_char = next_char.unwrap();
            if next_char == '#' {
                dir = dir.turn_right();
                continue;
            }
        }
        position = next_position;
        positions.insert(position);
    }
    positions
        .iter()
        .map(|item| item.clone())
        .collect::<Vec<_>>()
}

fn part2(input: Vec<&str>) -> i64 {
    let grid = Grid::create(&input);
    let start_point = Finder::create(&input).find("^").get(0).unwrap().origin;
    // it only makes sense to put walls in the places it already goes thru
    visited_positions(&grid, start_point)
        .iter()
        .filter(|position| **position != start_point)
        .filter(|new_wall| is_loop(&new_wall, &start_point, &grid))
        .count() as i64
}

fn is_loop(new_wall: &[usize; 2], start_point: &[usize; 2], grid: &Grid) -> bool {
    let mut dir = Direction::new();
    let mut position = start_point.clone();
    let mut visited_positions: HashSet<PosDir> = HashSet::new();
    visited_positions.insert(PosDir {
        pos: position,
        dir: dir.simple(),
    });
    loop {
        let next_position = dir.position(position);
        if next_position == None {
            return false;
        }

        let next_position = next_position.unwrap();
        let next_char = grid.char_at(&next_position);
        if next_char == None {
            return false;
        } else {
            let next_char = next_char.unwrap();
            if next_char == '#' || (next_position == *new_wall) {
                dir = dir.turn_right();
                continue;
            }
        }
        position = next_position;
        let posdir = PosDir {
            pos: position,
            dir: dir.simple(),
        };
        if visited_positions.contains(&posdir) {
            return true;
        }
        visited_positions.insert(posdir);
    }
}

struct Direction {
    x: i64,
    y: i64,
}

impl Direction {
    fn new() -> Direction {
        Direction { x: 0, y: -1 }
    }

    /// This could be mutate itself to save an allocation
    fn turn_right(&self) -> Direction {
        if self.x == 0 && self.y == -1 {
            Direction { x: 1, y: 0 }
        } else if self.x == 1 && self.y == 0 {
            Direction { x: 0, y: 1 }
        } else if self.x == 0 && self.y == 1 {
            Direction { x: -1, y: 0 }
        } else {
            Direction { x: 0, y: -1 }
        }
    }

    fn position(&self, from: [usize; 2]) -> Option<[usize; 2]> {
        let next_x = self.x + from[0] as i64;
        let next_y = self.y + from[1] as i64;
        if next_x < 0 || next_y < 0 {
            return None;
        }
        Some([next_x.try_into().unwrap(), next_y.try_into().unwrap()])
    }

    fn simple(&self) -> [i64; 2] {
        [self.x, self.y]
    }
}

#[derive(PartialEq, Eq, Hash)]
struct PosDir {
    pos: [usize; 2],
    dir: [i64; 2],
}

#[cfg(test)]
mod test;
