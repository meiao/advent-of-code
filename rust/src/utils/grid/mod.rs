use std::fmt::{Debug, Display};

pub struct Grid {
    grid: Vec<String>,
    limits: [usize; 2],
}

impl Grid {
    pub fn create(data: &Vec<&str>) -> Grid {
        let y: usize = data.len();
        let x: usize = data[0].len();
        Grid {
            grid: data.iter().map(|line| line.to_string()).collect(),
            limits: [x, y],
        }
    }

    pub fn char_at_position(&self, x: usize, y: usize) -> Option<char> {
        if x >= self.limits[0] || y >= self.limits[1] {
            None
        } else {
            self.grid[y].chars().nth(x)
        }
    }

    pub fn char_at(&self, position: &[usize; 2]) -> Option<char> {
        self.char_at_position(position[0], position[1])
    }

    pub fn limits(&self) -> [usize; 2] {
        self.limits
    }
}

impl Display for Grid {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        self.grid.fmt(f)
    }
}

#[cfg(test)]
mod test;
