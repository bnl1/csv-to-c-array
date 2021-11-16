#!/bin/awk -f
BEGIN{
	header_loaded = 0;
	FS = ","
}
{
	if(header_loaded == 0){
		for(i = 2;i <= NF;i++){
			header[i-2] = $i;
		}
		out = $1 "[][] = {";
		header_loaded = 1;
	} else{
		if(NR != 2){
			out = out "\t"; 
		}
		out = out "[" $1 "] = {"
		for(i = 2;i <= NF; i++){
			if($i){
				out = out "[" header[i-2] "] = " $i; 
				if(i != NF){
					out = out ", ";
				}
			}
		}	
		out = out "}, \n";
	}	
}
END{
	out = substr(out, 0,length(out)-3);
	printf out "}\n";
}
