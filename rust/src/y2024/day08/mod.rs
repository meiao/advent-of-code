use crate::utils::{free, Grid};
use itertools::Itertools;
use std::collections::HashMap;

fn part1(input: Vec<&str>) -> i64 {
    let grid = Grid::create(&input);
    let antenna_map = map_antennas(&grid);
    let limits = grid.limits();
    free(grid);
    antenna_map
        .into_iter()
        .map(|(_signal, antennas)| locate_antinodes(antennas, &limits))
        .flatten()
        .unique()
        .count() as i64
}

fn map_antennas(grid: &Grid) -> HashMap<char, Vec<[usize; 2]>> {
    let mut map = HashMap::new();
    let limits = grid.limits();
    for x in 0..limits[0] {
        for y in 0..limits[1] {
            let pos = [x, y];
            if let Some(char_at) = grid.char_at(&pos) {
                if char_at != '.' {
                    map.entry(char_at).or_insert(Vec::new()).push(pos);
                }
            }
        }
    }
    map
}

fn locate_antinodes(antennas: Vec<[usize; 2]>, limits: &[usize; 2]) -> Vec<[usize; 2]> {
    antennas
        .into_iter()
        .combinations(2)
        .map(|comb| antinodes_for_pair(comb))
        .flatten()
        .filter(|pos| valid(pos, limits))
        .map(|pos| [pos[0] as usize, pos[1] as usize])
        .collect()
}

fn antinodes_for_pair(comb: Vec<[usize; 2]>) -> Vec<[i64; 2]> {
    if let (Some(a0), Some(a1)) = (comb.get(0), comb.get(1)) {
        let mut antinodes = vec![];
        let antenna0x = a0[0] as i64;
        let antenna0y = a0[1] as i64;
        let antenna1x = a1[0] as i64;
        let antenna1y = a1[1] as i64;
        antinodes.push([2 * antenna0x - antenna1x, 2 * antenna0y - antenna1y]);
        antinodes.push([2 * antenna1x - antenna0x, 2 * antenna1y - antenna0y]);
        antinodes
    } else {
        vec![]
    }
}

fn valid(pos: &[i64; 2], limits: &[usize; 2]) -> bool {
    if pos[0] < 0 || pos[1] < 0 || pos[0] as usize >= limits[0] || pos[1] as usize >= limits[1] {
        return false;
    }
    true
}

fn part2(input: Vec<&str>) -> i64 {
    let grid = Grid::create(&input);
    let antenna_map = map_antennas(&grid);
    let limits = grid.limits();
    free(grid);
    antenna_map
        .into_iter()
        .map(|(_signal, antennas)| locate_antinodes2(antennas, &limits))
        .flatten()
        .unique()
        .count() as i64
}

fn locate_antinodes2(antennas: Vec<[usize; 2]>, limits: &[usize; 2]) -> Vec<[usize; 2]> {
    antennas
        .into_iter()
        .combinations(2)
        .map(|comb| antinodes_line(comb, limits))
        .flatten()
        .map(|pos| [pos[0] as usize, pos[1] as usize])
        .collect()
}

fn antinodes_line(antennas: Vec<[usize; 2]>, limits: &[usize; 2]) -> Vec<[i64; 2]> {
    let mut antinodes = vec![];
    if let (Some(a0), Some(a1)) = (antennas.get(0), antennas.get(1)) {
        let a0x = a0[0] as i64;
        let a0y = a0[1] as i64;
        antinodes.push([a0x, a0y]);
        let ix = a0x - a1[0] as i64;
        let iy = a0y - a1[1] as i64;
        let mut i = 1;
        loop {
            let antinode = [a0x + ix * i, a0y + iy * i];
            if !valid(&antinode, limits) {
                break;
            }
            antinodes.push(antinode);
            i += 1;
        }

        i = -1;
        loop {
            let antinode = [a0x + ix * i, a0y + iy * i];
            if !valid(&antinode, limits) {
                break;
            }
            antinodes.push(antinode);
            i -= 1;
        }
    }
    antinodes
}

#[cfg(test)]
mod test;
