CREATE TABLE users(
	id SERIAL4 PRIMARY KEY,
	email_address VARCHAR(320) NOT NULL,
	account_funds NUMERIC(15,2),
	password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE games(
	id SERIAL4 PRIMARY KEY,
	home_team VARCHAR(500),
	away_team VARCHAR(500),
	home_odds DECIMAL(5,2),
	away_odds DECIMAL(5,2),
	start_time TIMESTAMP,
	end_time TIMESTAMP,
	description TEXT,
	status VARCHAR(100),
	game_type VARCHAR(300)
);

CREATE TABLE game_results(
	id SERIAL4 PRIMARY KEY,
	game_id INTEGER,
	winning_team VARCHAR(500)
);

CREATE TABLE bets(
	id SERIAL4 PRIMARY KEY,
	user_id INTEGER,
	type VARCHAR(350),
	game_id INTEGER,
	pay_rate DECIMAL(5,2),
	amount NUMERIC(15,2)
);

CREATE TABLE bet_outcomes(
	id SERIAL4 PRIMARY KEY,
	bet_id INTEGER,
	status VARCHAR(100)
);
