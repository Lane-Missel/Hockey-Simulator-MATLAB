classdef Personal < handle

	properties
		
		name
		age
		number
		position
		nationality
		
	end
		

	methods

		function self = Personal()

			disp('Enter player information:')
			self.name = input('Name: ', 's');
			self.age = input('Age: ');
			self.number = input('Number: ');
			self.position = input('Position (1=F,2=D,3=G): ');
			self.nationality = input('Nationality: ', 's');

		end

	end
end
