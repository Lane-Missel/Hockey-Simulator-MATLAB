function [] = Simulate_Game(LCPHL_Data)

	%{
		Simulate_Game simulates a game og 3v3 hockey between two team.
		The function takes inputs from the user to choose the league and teams
		who are to play. It the prints the result to a text file. Statistics
		are automatically updated throughout excecution of the function.
	%}

	% load the team handles
	% load other variables


	% Have user select league.

	switch input('Choose league:\n1 - Major\n2 - Minor\nSelect: ')
		case 1
			TeamList = MajorTeamList;
			disp('Major league selected.')
		case 2
			TeamList = MinorTeamList;
			disp('Minor league selected')
		otherwise
			error('Invalid input.')
	end


	% Have user select home team.

	disp('Choose home team:')
	disp('1 - ' + TeamList.names(1))
	disp('2 - ' + TeamList.names(2))
	disp('3 - ' + TeamList.names(3))
	disp('4 - ' + TeamList.names(4))

	switch input('Select: ')
		case 1
			homeTeam = TeamList.teams(1);
			disp(TeamList.names(1) + 'selected.')
			TeamList.teams(1) = [];
			TeamList.names(1) = [];

		case 2
			homeTeam = TeamList.teams(2);
			disp(TeamList.names(2) + 'selected.')
			TeamList.teams(2) = [];
			TeamList.names(2) = [];

		case 3
			homeTeam = TeamList.teams(3);
			disp(TeamList.names(3) + 'selected.')
			TeamList.teams(3) = [];
			TeamList.names(3) = [];

		case 4
			homeTeam = TeamList.teams(4);
			disp(TeamList.names(4) + 'selected.')
			TeamList.teams(4) = [];
			TeamList.teams(4) = [];

		otherwise
			error('Invalid input.')
	end


	% Have user select away team.

	disp('Choose away team:')
	disp('1 - ' + TeamList.names(1));
	disp('2 - ' + TeamList.names(2));
	disp('3 - ' + TeamList.names(3));

	switch input('Select: ')
		case 1
			awayTeam = TeamList.teams(1);
			disp(TeamList.names(1) + 'selected.')

		case 2
			awayTeam = TeamList.teams(2);
			disp(TeamList.names(2) + 'selected.')

		case 3
			awayTeam = TeamList.teams(3);
			disp(TeamList.names(3) + 'selected.')

		otherwise
			error('Invalid input.')
	end


	% Loop through halves.

	for half = 1:2

		% Loop through minutes.

		for time = 1:10

			% Assign lines base on minute.

			switch mod(time,2)
				case 0
					homeLine = homeTeam.lines.two;
					awayLine = awayTeam.lines.two;

				case 1
					homeLine = homeTeam.lines.one;
					awayLine = awayTeam.lines.one;
			end


			% Home variables.
			homePassing = ...
				homeLine.one.attributes.passing + ...
				homeLine.two.attributes.passing + ...
				homeLine.three.attributes.passing;

			homeDefence = ...
				homeLine.one.attributes.defence + ...
				homeLine.two.attributes.defence + ...
				homeLine.three.attributes.defence;

			homePD = homePassing + homeDefence;

			% Away variables.
			awayPassing = ...
				awayLine.one.attributes.passing + ...
				awayLine.two.attributes.passing + ...
				awayLine.three.attributes.passing;

			awayDefence = ...
				awayLine.one.attributes.defence + ...
				awayLine.two.attributes.defence + ...
				awayLine.three.attributes.defence;

			awayPD = awayPassing + awayDefence;


			% Calculate possession.

			randVar = rand() * (homePD + awayPD)

			if randVar <= homePD
				offenceLine = homeLine;
				defenceLine = awayLine;
				goalie = awayLines.goalie;

				offencePassing = homePassing;
				defenceDefence = awayDefense;

			else
				offenceLine = awayLine;
				defenceLine = homeLine;
				goalie = homeLines.goalie;

				offencePassing = awayPassing;
				defenceDefence = homeDefence;
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

				% Pass successful. Calculate is shot is successful.

				randVar = rand() * (shooter.attributes.shooting + goalie.attributes.overall)

				if randVar <= shooter.attributes.shooting
					goal()

				else
					saved()
				end
			end


			% End of minute.
		end

		%{
			Update boxscore after each half.
			Update event list after each half.
		%}

		% End of half.
	end

	%{
		Print Header for Game.
		Print Boxscore.
		Print event list.
		Update team standings.
	%}

	% End of function.
end

% Subfunctions





% Subfunctions for updating statistics.

function [] = Goal()
	% Updates statistics if a goal was scored.


	% Update offensive statistics.
	shooter.Scored()
	passer.Assisted()

	offenceLine.one.Plus()
	offenceLine.two.Plus()
	offenceLine.three.Plus()

	% Update defensive statistics.
	defenceLine.one.Minus()
	defenceLine.two.Minus()
	defenceLine.three.Minus()

	goalie.Goal_Against()
end


function [] = Saved()
	% Updates statistics if the shot was saved.

	goalie.Shot_Saved()
end
























