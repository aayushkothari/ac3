'''Implementation of the AC-3 algorithm (http://en.wikipedia.org/wiki/AC-3_algorithm) for Australia Map-Coloring problem 
provided in Artificial Intelligence- A Modern Approach. 
The map can be found at http://bit.ly/YxRxAK.

Note: The input hash has been hard-coded instead of taking user input. This was only done because the main intention 
was to implement the algorithm. '''
 
$neighbors={ 'WA'=>['SA','NT'],
		'SA' => ['WA','NT','Q','NSW','V'],
		'NT'=> ['WA','SA','Q'],
		'Q'=>['NT','SA','NSW'],
		'NSW'=>['Q','SA','V'],
		'V'=>['SA','NSW'],	
		'T'=>[]
	}

'''Since AC-3 basically just reduces domains of variables based on the constraints implied, kindly change the domain of 1 or more 
variables here to see the effect on domains of other variables.''' 

$domain={'WA'=>['R'],
			'SA'=>['G'],
			'NT'=>['R','G','B'],
			'Q'=>['R','G','B'],
			'NSW'=>['R','G','B'],
			'V'=>['R','G','B'],
			'T'=>['R','G','B']
		}
color={'WA'=>'', 'SA' => '', 'NT'=>'', 'Q'=>'' , 'NSW' => '' , 'V' => '' , 'T' => ''}

def remove_inconsistent_values(i,j)
	removed=false
	for x in $domain[i]
		flag=0
		for y in $domain[j]
			if x!=y
				flag=1
				break
			end
		end
		if flag==0
			$domain[i].delete(x)
			removed=true
		end
	end
	return removed
end

def AC3(graph)
	q=Array.new
	len=0
	i,j="" , ""
	graph.each_key { |x|
		#unless x.length!=0
			graph[x].each {  |y|
				arc=[x,y]
				q.unshift(arc)
			}
	}
	while q.length!=0
		vars=q.pop
		i,j=vars[0],vars[1]
		if remove_inconsistent_values(i,j)
			for k in $neighbors[i]
				arcc=[k,i]
				q.unshift(arcc)
			end
		end
	end
end 

puts "Initially: "
$neighbors.each_key {|x|
	printf x+": "+$domain[x].to_s
	puts
	}
puts 
puts "After applying AC-3 on above constraints+domains...:"
puts
AC3($neighbors)
$neighbors.each_key {|x|
	printf x+": "+$domain[x].to_s
	puts
	}
