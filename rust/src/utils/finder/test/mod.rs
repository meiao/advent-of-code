use crate::utils::finder::Vector;
use crate::utils::Finder;

#[test]
fn test_finder() {
    let finder = Finder::create(&DATA.split("\n").collect());
    assert_eq!(
        vec![Vector {
            origin: [0, 1],
            direction: [0, 0]
        }],
        finder.find("3")
    );
    assert_eq!(0, finder.find("5").len());

    assert_eq!(
        vec![Vector {
            origin: [0, 0],
            direction: [1, 0]
        }],
        finder.find("12")
    );
    assert_eq!(0, finder.find("ab").len());
}

const DATA: &str = r#"12
34"#;
