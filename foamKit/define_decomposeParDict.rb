module M_foamKit	
	
	def self.define_decomposeParDict
		
		# Retrieve number of processors
		
		n_processors = $domain['n_processors']
		subdomains = M_foamKit.get_subdomains

		
		return body_text =
"/*--------------------------------*- C++ -*----------------------------------*\\
| =========                 |                                                 |
| \\\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\\    /   O peration     | Version:  plus                                  |
|   \\\  /    A nd           | Web:      www.OpenFOAM.com                      |
|    \\\/     M anipulation  |                                                 |
\\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    location    #{'"'}system#{'"'};
    object      decomposeParDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

numberOfSubdomains #{n_processors};

method          simple;

simpleCoeffs
{
    n               (#{subdomains[0]} #{subdomains[1]} #{subdomains[2]});
    delta           0.001;
}

hierarchicalCoeffs
{
    n               (1 1 1);
    delta           0.001;
    order           xyz;
}

manualCoeffs
{
    dataFile        "";
}

distributed     no;

roots           ( );


// ************************************************************************* //"
	end
	
end	