/*scr_sequence_more_recent()
* returns most recent sequence account for sequence wrap around
* argument0 - s1, incoming sequence
* argument1 - s2, old sequence
* argument2 - max
*/
s1 = argument0;
s2 = argument1;
smax = argument2;
//start
    {
    return 
        ( s1 > s2 ) and 
        ( s1 - s2 <= smax/2 ) 
           or
        ( s2 > s1 ) and 
        ( s2 - s1  > smax/2 );
    }
