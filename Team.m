classdef Team < handle

	properties

		roster
		lineup
		coach

	end


	methods

		function self = Team()

			self.roster = input('Roster variable name: ');
			self.lineup = input('Lineup variable name: ');
		end

		function self = AssignCoach(self)

			self.coach = input('Coach variable name: ');
		end
	end
end
