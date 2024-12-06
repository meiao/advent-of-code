use super::*;

#[test]
fn grid_test() {
    let grid = Grid::create(&DATA.split("\n").collect());
    assert_eq!(grid.char_at_position(0, 0), Some('1'));
    assert_eq!(grid.char_at_position(0, 1), Some('4'));
    assert_eq!(grid.char_at_position(1, 1), Some('5'));
    assert_eq!(grid.char_at_position(0, 2), None);
    assert_eq!(grid.char_at_position(3, 0), None);
    assert_eq!(grid.limits[0], 3);
    assert_eq!(grid.limits[1], 2);
}

const DATA: &str = r#"123
456"#;
