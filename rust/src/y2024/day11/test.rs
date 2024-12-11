use super::*;

#[test]
fn test_2024_11_part_1_small() {
    let result = solve(INPUT_SMALL, 25);
    assert_eq!(result, 55_312);
}

#[test]
fn test_2024_11_part_1_big() {
    let result = solve(INPUT, 25);
    assert_eq!(result, 222_461);
}

#[test]
fn test_2024_11_part_2_small() {
    let result = solve(INPUT_SMALL, 75);
    assert_eq!(result, 65_601_038_650_482);
}

#[test]
fn test_2024_11_part_2_big() {
    let result = solve(INPUT, 75);
    assert_eq!(result, 264_350_935_776_416);
}

const INPUT_SMALL: &str = r#"125 17"#;

const INPUT: &str = r#"2 54 992917 5270417 2514 28561 0 990"#;
