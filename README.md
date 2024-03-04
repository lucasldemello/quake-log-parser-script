# Quake Log Parser

This project implements a log parser for Quake III Arena game logs. It reads the log file, groups the game data of each match, and collects kill data.

## Requirements

- Git
- A development environment with Ruby installed

## How to Run the Script

1. Clone this repository:
   
```bash
git clone https://github.com/your-username/quake-log-parser.git
```

3. Navigate to the project directory:

```bash
cd quake-log-parser
```

3. Run the `quake_log_parser.rb`

```bash
ruby quake_log_parser.rb
```

4. The script will process the log file and print out the match statistics in the console. Like in this example.

```bash
game_12:
Total kills: 121
Players: Assasinu Credi, Chessus, Zeh, Dono da Bola, Isgalamido, Oootsimo, Mal
Kills:
Assasinu Credi: 23
Zeh: 14
Isgalamido: 26
Chessus: 17
Oootsimo: 22
Mal: 8
Dono da Bola: 11
Kills by means:
MOD_RAILGUN: 38
MOD_ROCKET_SPLASH: 35
MOD_BFG_SPLASH: 8
MOD_ROCKET: 25
MOD_MACHINEGUN: 7
MOD_BFG: 8
------------------------
```


## Contribution

If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request in this repository.
