classdef Organization < handle

	properties

		% Names.
		organizationName

		majorTeamName
		minorTeamName

		% Teams.
		majorTeam
		minorTeam

		% Other.
		staff

	end


	methods

		function self = Organization()

			organizationName = input('Please insert organization name: ');

			majorTeamName = input('Please insert major league team name: ');
			minorTeamName = input('Please insert minor league team name: ');

			majorTeam = input('Major team variable name: ');
			minorteam = input('Minor team variable name: ');

			staff = input('Staff varibale name: ');
		end

	end
end
