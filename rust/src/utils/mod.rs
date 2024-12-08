pub use finder::Finder;
pub use free::free;
pub use grid::Grid;

mod finder;
mod grid;

mod free {
    pub fn free<T>(_: T) -> () {}
}
