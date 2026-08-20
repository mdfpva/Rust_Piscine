const PISCINE: &str = "Rust";

fn main() {
    let piscine0: &str = PISCINE;
    println!("piscine0 = {}", piscine0);
    let mut piscine1: &str = piscine0;
    println!("piscine1 = {}", piscine1);
    piscine1 = "rUST";
    println!("piscine1 = {}", piscine1);
    let piscine0: &str = "rUST";
    println!("piscine0 = {}", piscine0);
}
