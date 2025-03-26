use std::collections::HashMap;
use std::io::{self, Write};

fn main() {
    let mut vars: HashMap<String, f64> = HashMap::new();

    loop {
        print!("Enter expression: ");
        io::stdout().flush().unwrap();
        
        let mut input = String::new();
        io::stdin().read_line(&mut input).unwrap();
        let input = input.trim();

        if input == "exit" {
            break;
        }

        let parts: Vec<&str> = input.split_whitespace().collect();

        // assignment mi
        if parts.len() == 3 && parts[1] == "=" {
            let var_name = parts[0];
            let operator = parts[1];
            let value: f64 = match parts[2].parse() {
                Ok(val) => val,
                Err(_) => {
                    println!("Invalid value for assignment.");
                    continue;
                }
            };

            match operator {
                "=" => {
                    vars.insert(var_name.to_string(), value);
                    println!("Set {} = {}", var_name, value);
                }
                _ => println!("Unknown operator."),
            }
        }
        // cok elemanli islemler (x + y + 3 gibi)
        else if parts.len() >= 3 {
            let mut result = 0.0;
            let mut operator = "+";

            for part in parts.iter() {
                if *part == "+" || *part == "-" || *part == "*" || *part == "/" {
                    operator = *part;
                } else {
                    //sayi mi variable mi
                    let value = match part.parse::<f64>() {
                        Ok(val) => val,
                        Err(_) => *vars.get(*part).unwrap_or(&0.0),
                    };

                    match operator {
                        "+" => result += value,
                        "-" => result -= value,
                        "*" => result *= value,
                        "/" => {
                            if value != 0.0 {
                                result /= value;
                            } else {
                                println!("Error: Division by zero");
                                result = 0.0;
                                break;
                            }
                        }
                        _ => println!("Unknown operator."),
                    }
                }
            }

            println!("Result: {}", result);
        } else {
            println!("Invalid expression");
        }
    }
}
