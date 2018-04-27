mod consts;

use std::collections::HashMap;

fn main() {
    println!("Hello, world!");
    let mut map = HashMap::new();
    map.insert(consts::HELLO, consts::WORLD);

    for (key, value) in &map {
        println!("{} {}", key, value);
        println!("What fun.")
    }
}
