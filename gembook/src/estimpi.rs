extern crate rand;

use rand::Rng;
use std::cmp::Ordering;

const ITERATIONS: u64 = 1000000000;
const RADIUS: f64 = 1_f64;

fn estimpi() {
    let mut counter = 0;
    let mut successes = 0;
    loop {
        match counter {
            ITERATIONS => break,
            _ => counter = counter + 1,
        }

        let rand1: f64 = rand::thread_rng().gen_range(-1_f64, 1_f64);
        let rand2: f64 = rand::thread_rng().gen_range(-1_f64, 1_f64);

        let distance: f64 = dist(rand1, rand2);

        match distance.partial_cmp(&RADIUS) {
            Some(Ordering::Less) => successes = successes + 1,
            Some(_) => (),
            None => (),
        }
    }

    // Pi is circumference / diameter
    let area: f64 = successes as f64 / ITERATIONS as f64;
    let kindapi = area / RADIUS.powf(2_f64) * 4_f64;

    println!(
        "There were {} iterations and {} successes. Pi is probably {}.",
        ITERATIONS, successes, kindapi,
    );
}

fn dist(num1: f64, num2: f64) -> f64 {
    let a = num1.powf(2_f64);
    let b = num2.powf(2_f64);
    let c = (a + b).sqrt();

    return c;
}
