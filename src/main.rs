use serde_json::Value;
use std::{env, fs};

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 3 {
        eprintln!("Usage: {} <input> <output>", args[0]);
        return;
    }

    let input_path = &args[1];
    let output_path = &args[2];

    // Read JSON file
    let json_content = fs::read_to_string(input_path).expect("Failed to read input file");
    let json_value: Value = serde_json::from_str(&json_content).expect("Invalid JSON");

    // Serialize to bincode
    let bincode_data = bincode::serialize(&json_value).expect("Failed to serialize to bincode");

    // Write to output file
    fs::write(output_path, bincode_data).expect("Failed to write output file");

    println!("Successfully converted JSON to bincode: {}", output_path);
}

