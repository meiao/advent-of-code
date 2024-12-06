use crate::utils::*;

fn part1(input: Vec<&str>) -> i64 {
    let finder = Finder::create(&input);
    finder.find("XMAS").len().try_into().unwrap()
}

fn part2(input: Vec<&str>) -> i64 {
    let grid = Grid::create(&input);
    Finder::create(&input)
        .find("A")
        .iter()
        .map(|vector| vector.origin)
        .filter(|pos| pos[0] != 0 && pos[1] != 0) // As on the first line or column cannot be X-MAS
        .filter(|pos| check_diagonals(pos, &grid))
        .count() as i64
}

fn check_diagonals(origin: &[usize; 2], grid: &Grid) -> bool {
    check_diagonal(
        [
            [origin[0] + 1, origin[1] + 1],
            [origin[0] - 1, origin[1] - 1],
        ],
        grid,
    ) && check_diagonal(
        [
            [origin[0] + 1, origin[1] - 1],
            [origin[0] - 1, origin[1] + 1],
        ],
        grid,
    )
}

fn check_diagonal(positions: [[usize; 2]; 2], grid: &Grid) -> bool {
    let chars: Vec<char> = positions
        .iter()
        .map(|pos| grid.char_at(pos))
        .filter(Option::is_some)
        .map(Option::unwrap)
        .collect();
    if !chars.contains(&'M') || !chars.contains(&'S') {
        return false;
    }
    true
}

#[cfg(test)]
mod test;
