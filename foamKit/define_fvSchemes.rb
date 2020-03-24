module M_foamKit

	def self.define_fvSchemes
		
		schemes_settings = $domain['schemes_settings']
		
		schemes_block = ""
		schemes_settings.each { |key, value|
			schemes_block = schemes_block + M_foamKit.create_block(value, key)				
		}
			
		return body_text = 	
"/*--------------------------------*- C++ -*----------------------------------*\\
| =========                 |                                                 |
| \\\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\\    /   O peration     | Version:  2.0.x                                 |
|   \\\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    location    #{'"'}system#{'"'};	
    object      fvSchemes;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
#{schemes_block}

// ************************************************************************* //"	
	
	end
	
	
	def self.create_block(h, name, level_index = 0, block = "")
	  tbs = M_foamKit.get_tbs(level_index)
	  block << "\n#{tbs}#{name}"
		block << "\n#{tbs}{"
		h.each { |key, value|
			if value.is_a?(Hash)
				create_block(value, key.to_s, level_index+1, block)
				tbs = M_foamKit.get_tbs(level_index)			
			else
				e_tbs = M_foamKit.get_entry_tbs(key.to_s)
				block << "\n#{tbs}	#{key.to_s}#{e_tbs}#{value.to_s};"		
			end
		}
		block << "\n#{tbs}}\n"
	end	

	def self.get_tbs(level_index)
	  if level_index==0
		return ""
	  end
	  tbs = ""
	  level_index.times do |i|
		tbs << "\t"
	  end
	  return tbs
	end	

	def self.get_entry_tbs(entry)
		# Process to print the entries and values with standard OpenFOAM tabs
		entry_string_length = entry.length
		e_tbs = ""
		if entry_string_length < 4
			tbs = "\t\t\t\t"
		elsif entry_string_length < 8
			e_tbs = "\t\t\t"
		elsif entry_string_length < 12
			e_tbs = "\t\t"
		elsif entry_string_length < 32
			e_tbs = "\t"			
		end		
	end	
	
	
end # module M_foamKit