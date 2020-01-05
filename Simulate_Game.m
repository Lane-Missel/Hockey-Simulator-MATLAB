function [] = Simulate_Game(AA,BB,AStats,BStats)

	%{
		Simulate_Game simulates a game of 3v3 hockey between two team.
		The function takes inputs from the user to choose the league and teams
		who are to play. It the prints the result to a text file. Statistics
		are automatically updated throughout excecution of the function.
	%}

	% Load data.

	homeTeam = AA;
	awayTeam = BB;
	homeStats = AStats;
	awayStats = BStats;

	homeAbr = 'ALP';
	awayAbr = 'BRA';


	% load('LCPHL_Data.mat', 'HawksLineup_1');
	% load('LCPHL_Data.mat', 'ArrowsLineup_1');

	% homeTeam = HawksLineup_1;
	% awayTeam = ArrowsLineup_1;

	% Have user input team lineups:

	% homeTeam = input('Home Lineup: ');
	% awayTeam = input('Away Lineup: ');

	% Initiate boxscore;

	homeName = input('Home Name: ');
	awayName = input('Away Name: ');

	gameNum = input('Game #: ', 's');

	homeBox = Boxscore();
	awayBox = Boxscore();

	% Select game type via input from user.

	switch input('Enter (1-Exhibition,2-Major,3-Minor): ')
		case 1
			gameType = 1;

		case 2
			gameType = 2;

		case 3
			gameType = 3;
	end

	% Initialize lists.	

	firstList = {};
	secondList = {};

	% eventList = {'half minute team goal assist'};

	% Loop through halves.

	for int = 1:2

		% Loop through minutes.

		for time = 1:10

			% Assign lines base on minute.

			switch mod(time,2)
				case 0
					homeLine = homeTeam.one;
					awayLine = awayTeam.two;

				case 1
					homeLine = homeTeam.two;
					awayLine = awayTeam.one;
			end


			% Home variables.
			homePassing = ...
				homeLine.one.attributes.passing + ...
				homeLine.two.attributes.passing + ...
				homeLine.three.attributes.passing;

			homeDefence = ...
				homeLine.one.attributes.defending + ...
				homeLine.two.attributes.defending + ...
				homeLine.three.attributes.defending;

			homePD = homePassing + homeDefence;

			homeGoal = homeTeam.goalie;

			% Away variables.
			awayPassing = ...
				awayLine.one.attributes.passing + ...
				awayLine.two.attributes.passing + ...
				awayLine.three.attributes.passing;

			awayDefence = ...
				awayLine.one.attributes.defending + ...
				awayLine.two.attributes.defending + ...
				awayLine.three.attributes.defending;

			awayPD = awayPassing + awayDefence;

			awayGoal = awayTeam.goalie;

			% Calculate possession.

			randVar = rand() * (homePD + awayPD);

			if randVar <= homePD
				offenceLine = homeLine;
				defenceLine = awayLine;
				goalie = awayGoal;

				offencePassing = homePassing;
				defenceDefence = awayDefence;

				offenceBox = homeBox;
				defenceBox = awayBox;
				offenceBox.AddTop();

				offenceName = homeName;
				offAbr = homeAbr;

			else
				offenceLine = awayLine;
				defenceLine = homeLine;
				goalie = homeGoal;

				offencePassing = awayPassing;
				defenceDefence = homeDefence;

				offenceBox = awayBox;
				defenceBox = homeBox;
				offenceBox.AddTop();

				offenceName = awayName;
				offAbr = awayAbr;

			end

			% Calculate passing player.

			randVar = rand() * offencePassing;

			if randVar <= offenceLine.one.attributes.passing
				passer = offenceLine.one;
				shooters = [offenceLine.two; offenceLine.three];

			elseif randVar <= ...
				offenceLine.one.attributes.passing + ...
				offenceLine.two.attributes.passing;

				passer = offenceLine.two;
				shooters = [offenceLine.one; offenceLine.three];

			else
				passer = offenceLine.three;
				shooters = [offenceLine.one; offenceLine.two];
			end


			% Calculate if pass to shooter is successful.

			randVar = rand() * (passer.attributes.passing * 3 + defenceDefence);

			if randVar <= passer.attributes.passing * 3

				% Pass successful. Calculate shooting player.

				randVar = rand() * ( shooters(1).attributes.shooting + shooters(2).attributes.shooting );

				if randVar <= shooters(1).attributes.shooting
					shooter = shooters(1);
				
				else
					shooter = shooters(2);
				end
				
				% Calculate if shot is successful.

				randVar = rand() * (shooter.attributes.shooting + goalie.attributes.overall);

				if randVar <= shooter.attributes.shooting

					% Goal scored.
					% Update relevent statistics.

					if gameType == 1
						% Game type = exhibition.
				
						% Update offensive statistics.
						shooter.exhibitionStats.Goal();
						passer.exhibitionStats.Assist();
				
						offenceLine.one.exhibitionStats.Plus();
						offenceLine.two.exhibitionStats.Plus();
						offenceLine.three.exhibitionStats.Plus();
				
						% Update boxscore.
						if int == 1
							offenceBox.First();
						else
							offenceBox.Second();
						end
				
						% Update defensive statistics.
						defenceLine.one.exhibitionStats.Minus();
						defenceLine.two.exhibitionStats.Minus();
						defenceLine.three.exhibitionStats.Minus();
				
						goalie.exhibitionStats.goalAgainst();
				
					elseif gameType == 2
						% Game type = major league.
				
						% Update offensive statistics.
						shooter.majorStats.Goal();
						passer.majorStats.Assist();
				
						offenceLine.one.majorStats.Plus();
						offenceLine.two.majorStats.Plus();
						offenceLine.three.majorStats.Plus();
				
						% Update boxscore.
						if int == 1
							offenceBox.First();
						else
							offenceBox.Second();
						end
				
						% Update defensive statistics.
						defenceLine.one.majorStats.Minus();
						defenceLine.two.majorStats.Minus();
						defenceLine.three.majorStats.Minus();
				
						goalie.majorStats.goalAgainst;

					else
						% Game type = minor league.
				
						% Update offensive statistics.
						shooter.minorStats.Goal();
						passer.minorStats.Assist();
				
						offenceLine.one.minorStats.Plus();
						offenceLine.two.minorStats.Plus();
						offenceLine.three.minorStats.Plus();
				
						% Update boxscore.
						if int == 1
							offenceBox.First();
						else
							offenceBox.Second();
						end
				
						% Update defensive statistics.
						defenceLine.one.minorStats.Minus();
						defenceLine.two.minorStats.Minus();
						defenceLine.three.minorStats.Minus();
				
						goalie.minorStats.goalAgainst();
				
					end
				
					% Update list of events.

					if int == 1
						% First half.
						firstList = [firstList; sprintf('%d %s Goal: #%d %s, Assist: #%d %s.', time, offAbr, shooter.personal.number, shooter.personal.name, passer.personal.number, passer.personal.name)];
					
					else
						% Second half.
						secondList = [secondList; sprintf('%d %s Goal: #%d %s, Assist: #%d %s.', time + 10, offAbr, shooter.personal.number, shooter.personal.name, passer.personal.number, passer.personal.name)];
					end

				else
					% Shot saved.

					if gameType == 1
						goalie.exhibitionStats.shotAgainst();
						offenceBox.AddShot();
				
					elseif gameType == 2
						goalie.majorStats.shotAgainst();
						offenceBox.AddShot();
				
					else
						goalie.minorStats.shotAgainst();
						offenceBox.AddShot();
					end
				end
			end
			% End of minute.
		end
		% End of half.
	end
	% End of game.

	% Decide result of game.
	if homeBox.score > awayBox.score
		homeStats.Win();
		awayStats.Loss();
		result = 1;
	
	elseif awayBox.score > homeBox.score
		awayStats.Win();
		homeStats.Loss();
		result = 2;

	else
		homeStats.Tie();
		awayStats.Tie();
		result = 3;
	end

	% Update team statistics.
	homeStats.updateGoals(homeBox.score,awayBox.score);
	awayStats.updateGoals(awayBox.score,homeBox.score);

	homeStats.updateShots(homeBox.shots,awayBox.shots);
	awayStats.updateShots(awayBox.shots,homeBox.shots);

	homeStats.AddTOP(homeBox.top);
	awayStats.AddTOP(awayBox.top);

	homeStats.UpdatePerc();
	awayStats.UpdatePerc();

	% Print game information to a text file and to the command window.
	
	% Open respective text files.
	if gameType == 1
		FID = fopen('Exhibition_Games.txt', 'a');
		gamePrint = 'Exhibition';

	elseif gameType == 2
		FID = fopen('Major2020_Games.txt', 'a');
		gamePrint = 'Major League';

    else
		FID = fopen('Minor2020_Games.txt', 'a');
		gamePrint = 'Minor League';
	end

	% Write to respective text file.

	% Game header.
	fprintf(FID,'\nSTART OF GAME #%s ----------\n\n%s (%d-%d-%d) @  (%d-%d-%d) %s\n\n', ...
		gameNum, awayName, awayStats.wins, awayStats.losses, awayStats.ties, homeStats.wins, homeStats.losses, homeStats.ties, homeName)

	% Write game result.
	switch result
		case 1
			fprintf(FID,'%s def. %s %d - %d\n\n',homeName, awayName, homeBox.score, awayBox.score)
			fprintf('%s def. %s %d - %d\n',homeName, awayName, homeBox.score, awayBox.score)
		case 2
			fprintf(FID,'%s def. %s %d - %d\n\n',awayName, homeName, awayBox.score, homeBox.score)
			fprintf('%s def. %s %d - %d\n',awayName, homeName, awayBox.score, homeBox.score)
		case 3
			fprintf(FID,'%s tie %s %d - %d\n\n', homeName, awayName, homeBox.score, awayBox.score)
			fprintf('%s tie %s %d - %d\n', homeName, awayName, homeBox.score, awayBox.score)
	end

	% Write boxscore.
	fprintf(FID, '%4s %2s %2s %2s %6s %4s\n', 'Team', '1', '2', 'T', 'Shots', 'TOP')
	fprintf(FID, '%4s %2d %2d %2d %6d %4d\n', awayAbr, awayBox.first, awayBox.second, awayBox.score, awayBox.shots, awayBox.top)
	fprintf(FID, '%4s %2d %2d %2d %6d %4d\n', homeAbr, homeBox.first, homeBox.second, homeBox.score, homeBox.shots, homeBox.top)

	% Write events.

	% First half.
	fprintf(FID,'\n')
	fprintf(FID, 'First half:\n')
	
	tally = homeBox.first + awayBox.first;

	if tally ~= 0
		for i = 1:tally
			txt = firstList{i};
			fprintf(FID,txt)
			fprintf(FID,'\n')
		end
	else
		fprintf(FID,'No scoring.\n')
	end

	% Second half.
	fprintf(FID,'\n')
	fprintf(FID, 'Second half:\n')

	tally = homeBox.second + awayBox.second;

	if tally ~= 0
		for i = 1:tally
			txt = secondList{i};
			fprintf(FID,txt)
			fprintf(FID,'\n')
		end
	else
		fprintf(FID,'No scoring.\n')
	end

	fprintf(FID,'\nEND OF GAME --------------------\n\n\n')

	fclose(FID)
	
	% Update relevent statistics after game.
	
	if gameType == 1
		% Exhibition Game.
		% Skater stats.
		homeTeam.one.one.exhibitionStats.GamePlayed();
		homeTeam.one.two.exhibitionStats.GamePlayed();
		homeTeam.one.three.exhibitionStats.GamePlayed();
		homeTeam.two.one.exhibitionStats.GamePlayed();
		homeTeam.two.two.exhibitionStats.GamePlayed();
		homeTeam.two.three.exhibitionStats.GamePlayed();

		awayTeam.one.one.exhibitionStats.GamePlayed();
		awayTeam.one.two.exhibitionStats.GamePlayed();
		awayTeam.one.three.exhibitionStats.GamePlayed();
		awayTeam.two.one.exhibitionStats.GamePlayed();
		awayTeam.two.two.exhibitionStats.GamePlayed();
		awayTeam.two.three.exhibitionStats.GamePlayed();

		% Goaltender stats.
		homeTeam.goalie.exhibitionStats.GamePlayed();
		homeTeam.goalie.exhibitionStats.updateGaa();
		homeTeam.goalie.exhibitionStats.updatePercent();
		awayTeam.goalie.exhibitionStats.GamePlayed();
		awayTeam.goalie.exhibitionStats.updateGaa();
		awayTeam.goalie.exhibitionStats.updatePercent();

	elseif gameType == 2
		% Major league game.
		% Skater stats.
		homeTeam.one.one.majorStats.GamePlayed();
		homeTeam.one.two.majorStats.GamePlayed();
		homeTeam.one.three.majorStats.GamePlayed();
		homeTeam.two.one.majorStats.GamePlayed();
		homeTeam.two.two.majorStats.GamePlayed();
		homeTeam.two.three.majorStats.GamePlayed();

		awayTeam.one.one.majorStats.GamePlayed();
		awayTeam.one.two.majorStats.GamePlayed();
		awayTeam.one.three.majorStats.GamePlayed();
		awayTeam.two.one.majorStats.GamePlayed();
		awayTeam.two.two.majorStats.GamePlayed();
		awayTeam.two.three.majorStats.GamePlayed();

		% Goaltender stats.
		homeTeam.goalie.majorStats.GamePlayed();
		homeTeam.goalie.majorStats.updateGaa();
		homeTeam.goalie.majorStats.updatePercent();
		awayTeam.goalie.majorStats.GamePlayed();
		awayTeam.goalie.majorStats.updateGaa();
		awayTeam.goalie.majorStats.updatePercent();

	else
		% Minor league game.
		% Skater stats.
		homeTeam.one.one.minorStats.GamePlayed();
		homeTeam.one.two.minorStats.GamePlayed();
		homeTeam.one.three.minorStats.GamePlayed();
		homeTeam.two.one.minorStats.GamePlayed();
		homeTeam.two.two.minorStats.GamePlayed();
		homeTeam.two.three.minorStats.GamePlayed();

		awayTeam.one.one.minorStats.GamePlayed();
		awayTeam.one.two.minorStats.GamePlayed();
		awayTeam.one.three.minorStats.GamePlayed();
		awayTeam.two.one.minorStats.GamePlayed();
		awayTeam.two.two.minorStats.GamePlayed();
		awayTeam.two.three.minorStats.GamePlayed();

		% Goaltender stats.
		homeTeam.goalie.minorStats.GamePlayed();
		homeTeam.goalie.minorStats.updateGaa();
		homeTeam.goalie.minorStats.updatePercent();
		awayTeam.goalie.minorStats.GamePlayed();
		awayTeam.goalie.minorStats.updateGaa();
		awayTeam.goalie.minorStats.updatePercent();
	end
end
