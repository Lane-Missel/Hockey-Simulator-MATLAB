function [] = Simulate_Game(AA,BB)

	%{
		Simulate_Game simulates a game of 3v3 hockey between two team.
		The function takes inputs from the user to choose the league and teams
		who are to play. It the prints the result to a text file. Statistics
		are automatically updated throughout excecution of the function.
	%}

	% Load data.

	homeTeam = AA;
	awayTeam = BB;

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

	homeBox = Boxscore(homeName);
	awayBox = Boxscore(awayName);

	% Select game type via input from user.

	switch input('Enter (1-Exhibition,2-Major,3-Minor): ')
		case 1
			gameType = 1;

		case 2
			gameType = 2;

		case 3
			gameType = 3;
	end

	% Initialize list.	

	eventList = {'half minute team goal assist'};

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

			end

			% Calculate passing player.

			randVar = rand() * offencePassing;

			if randVar <= offenceLine.one.attributes.passing
				passer = offenceLine.one;
				shooters = [offenceLine.two; offenceLine.three];

			elseif randVar <= ...
				offenceLine.one.attributes.passing + ...
				offenceLine.two.attributes.passing

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
				
				% Calculate is shot is successful.

				randVar = rand() * (shooter.attributes.shooting + goalie.attributes.overall);

				if randVar <= shooter.attributes.shooting
					eventList = Goal(shooter,passer,offenceLine,defenceLine,goalie,offenceBox,gameType,int,eventList,time,offenceName);

				else
					Saved(goalie,gameType);
				end
			end

			% End of minute.
		end

	end

	% Open respective text files.

	if gameType == 1
		FID = fopen('Exhibition_Games.txt', 'a');
		gamePrint = 'Exhibition\n';

	elseif gameType == 2
		FID = fopen('Major2020_Games.txt', 'a');
		gamePrint = 'Major League\n';

    else
		FID = fopen('Minor2020_Games.txt', 'a');
		gamePrint = 'Minor League\n';
	end

	% Write to respective text files.

	fprintf(FID,'%s @  %s\n', awayName, homeName)
	fprintf(FID,'%f - %f\n', awayBox.score, homeBox.score)

	for i = 1:(homeBox.score + awayBox.score + 1)

		txt = eventList{i};
		fprintf(FID,'%s\n', txt)
	end

	fclose(FID)

	% Print to command line

	fprintf('%s\n', gamePrint)
	fprintf('%s @  %s\n', awayName, homeName)
	fprintf('%f - %f\n', awayBox.score, homeBox.score)

	for i = 1:(homeBox.score + awayBox.score + 1)

		txt = eventList{i};
		fprintf('%s\n', txt)
	end


	% Refresh goaltender statistics.

	if gameType == 1
		homeTeam.goalie.exhibitionStats.updateGaa();
		homeTeam.goalie.exhibitionStats.updatePercent();
		awayTeam.goalie.exhibitionStats.updateGaa();
		awayTeam.goalie.exhibitionStats.updatePercent();

	elseif gameType == 2
		homeTeam.goalie.majorStats.updateGaa();
		homeTeam.goalie.majorStats.updatePercent();
		awayTeam.goalie.majorStats.updateGaa();
		awayTeam.goalie.majorStats.updatePercent();

	else
		homeTeam.goalie.minorStats.updateGaa();
		homeTeam.goalie.minorStats.updatePercent();
		awayTeam.goalie.minorStats.updateGaa();
		awayTeam.goalie.minorStats.updatePercent();
	end

	% Subfunctions for updating statistics.

function eventList = Goal(shooter,passer,offenceLine,defenceLine,goalie,offenceBox,gameType,int,eventList,time,offenceName)
	% Updates statistics if a goal was scored.

	% Assign statistics to correct pool.

	if gameType == 1
		% Game type = exhibition.

		% Update offensive statistics.
		shooter.exhibitionStats.Goal()
		passer.exhibitionStats.Assist()

		offenceLine.one.exhibitionStats.Plus()
		offenceLine.two.exhibitionStats.Plus()
		offenceLine.three.exhibitionStats.Plus()

		% Update boxscore.
		if int == 1
			offenceBox.First();
		else
			offenceBox.Second();
		end

		% Update defensive statistics.
		defenceLine.one.exhibitionStats.Minus()
		defenceLine.two.exhibitionStats.Minus()
		defenceLine.three.exhibitionStats.Minus()

		goalie.exhibitionStats.goalAgainst()

	elseif gameType == 2
		% Game type = major league.

		% Update offensive statistics.
		shooter.majorStats.Goal()
		passer.majorStats.Assist()

		offenceLine.one.majorStats.Plus()
		offenceLine.two.majorStats.Plus()
		offenceLine.three.majorStats.Plus()

		% Update boxscore.
		if int == 1
			offenceBox.First();
		else
			offenceBox.Second();
		end

		% Update defensive statistics.
		defenceLine.one.majorStats.Minus()
		defenceLine.two.majorStats.Minus()
		defenceLine.three.majorStats.Minus()

		goalie.majorStats.goalAgainst()

	else
		% Game type = minor league.

		% Update offensive statistics.
		shooter.minorStats.Goal()
		passer.minorStats.Assist()

		offenceLine.one.minorStats.Plus()
		offenceLine.two.minorStats.Plus()
		offenceLine.three.minorStats.Plus()	

		% Update boxscore.
		if int == 1
			offenceBox.First();
		else
			offenceBox.Second();
		end

		% Update defensive statistics.
		defenceLine.one.minorStats.Minus()
		defenceLine.two.minorStats.Minus()
		defenceLine.three.minorStats.Minus()

		goalie.minorStats.goalAgainst();

	end

	% Update list of events.

	eventList = [eventList; sprintf('%d %d %s %d %s %d %s', int, time, offenceName, shooter.personal.number, shooter.personal.name, passer.personal.number, passer.personal.name)];

function [] = Saved(goalie,gameType)
	% Updates statistics if the shot was saved.

	if gameType == 1
		goalie.exhibitionStats.shotAgainst();

    elseif gameType == 2
		goalie.majorStats.shotAgainst();

	else
		goalie.minorStats.shotAgainst();
    end
    