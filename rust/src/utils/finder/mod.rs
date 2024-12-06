use crate::utils::Grid;

pub struct Finder {
    grid: Grid,
}

impl Finder {
    pub fn create(data: &Vec<&str>) -> Finder {
        Finder {
            grid: Grid::create(data),
        }
    }

    pub fn find(&self, value: &str) -> Vec<Vector> {
        if value.is_empty() {
            vec![]
        } else if value.len() == 1 {
            self.find_single_char(value.chars().nth(0).unwrap())
        } else {
            let value: Vec<char> = value.chars().collect();
            self.find_multi_char(value)
        }
    }

    fn find_single_char(&self, value: char) -> Vec<Vector> {
        let mut matches = vec![];
        for y in 0..(self.grid.limits()[1]) {
            for x in 0..(self.grid.limits()[0]) {
                let origin = [x, y];
                if self.grid.char_at(&origin) == Some(value) {
                    matches.push(Vector {
                        origin,
                        direction: [0, 0],
                    });
                }
            }
        }
        matches
    }

    fn find_multi_char(&self, value: Vec<char>) -> Vec<Vector> {
        let mut matches = vec![];
        for x in 0..(self.grid.limits()[0]) {
            for y in 0..(self.grid.limits()[1]) {
                matches.append(&mut self.find_cell(&value, [x, y]))
            }
        }
        matches
    }

    fn find_cell(&self, value: &Vec<char>, position: [usize; 2]) -> Vec<Vector> {
        if let Some(grid_char) = self.grid.char_at(&position) {
            if value[0] != grid_char {
                return vec![];
            }
        }
        [
            [0, 1],
            [0, -1],
            [1, 0],
            [-1, 0],
            [1, 1],
            [1, -1],
            [-1, 1],
            [-1, -1],
        ]
        .iter()
        .filter(|dir| self.has_value(value, position, **dir))
        .map(|direction| Vector {
            origin: position,
            direction: *direction,
        })
        .collect()
    }

    fn has_value(&self, value: &Vec<char>, position: [usize; 2], direction: [i64; 2]) -> bool {
        for i in 1..value.len() {
            let pos_i = Self::position_i(&position, &direction, i);
            if pos_i == None {
                return false;
            }
            let pos_i = pos_i.unwrap();
            let grid_char = self.grid.char_at(&pos_i);
            if grid_char == None || grid_char.unwrap() != value[i] {
                return false;
            }
        }
        true
    }

    fn position_i(position: &[usize; 2], direction: &[i64; 2], i: usize) -> Option<[usize; 2]> {
        let x = position[0] as i64 + direction[0] * (i as i64);
        let y = position[1] as i64 + direction[1] * (i as i64);
        if x < 0 || y < 0 {
            return None;
        }
        let asdf = [x.try_into().unwrap(), y.try_into().unwrap()];
        Some(asdf)
    }
}

#[derive(Debug, PartialEq)]
pub struct Vector {
    pub origin: [usize; 2],
    pub direction: [i64; 2],
}

#[cfg(test)]
mod test;
