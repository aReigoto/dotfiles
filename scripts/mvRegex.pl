#!/usr/bin/perl -w


# Part 1



print "Get list of files from comman:\n> ";
$getFiles = <>;
#$getFiles = "ls -1";



print "Please enter you regex for selection in respecting the syntax bellow:\n";
print 'm/$selectionRex/$flags',"\n";
print '$selectionRex'," = ";
$selectionRex = <>;
#$selectionRex = '.*\.jpg$';

# Part 2

print "Please enter your destination path:\n> ";
$destination = <>;
#$destination = "./";

print "Please enter you regex for subtitution in respecting the syntax bellow:\n";
print 's/$matchForNew/$newNameRex/ee',"\n";
print '$matchForNew = ';
$matchForNewTEMP = <STDIN>;
$matchForNewTEMP =~ s/[\n\r\f\t]//g;
$matchForNew = '$matchForNewTEMP';
print "$matchForNew";
#$matchForNew = '(.*)(.)jpg$';
print '$newNameRex = ';
$newNameRexTEMP = <STDIN>;
$newNameRexTEMP =~ s/[\n\r\f\t]//g;
$newNameRex = '"$newNameRexTEMP"';
print "$newNameRex";
#$newNameRex = '"$1$2txt"';

####################################
###############Part 1###############
####################################

chop $selectionRex;
$check = 0;
$nochek = 0;

@files = `$getFiles`;
foreach $file(@files){
	chop $file;
	if ($file =~ m/$selectionRex/ ) {
		#print "$file\n";
		push @Mach, $file;
		$check++;
	}
	else{
		push @noMach, $file;
		$nochek++;
	}
}

if (scalar(@Mach) != 0) {
	print "\nFiles selected:\n";
	print "$_\n" for @Mach;
}

if (scalar(@noMach) != 0) {
	print "\nUnmached files:\n";
	print "$_\n" for @noMach;
}

$totalN = scalar(@files);
print "\nTotal files:\t$totalN\nMatch files:\t$check\nNo match files:\t$nochek\n";

if ($check == 0) {
	print "\nBad regex no match found\n";
	exit;
}

undef @files;
undef $file;

####################################
###############Part 2###############
####################################


print "\nCommand to preform:\n";
@files = `$getFiles`;
foreach $file(@files){
	chop $file;
	if ($file =~ m/$selectionRex/i ) {
		$finalDestination = $file;
		$finalDestination =~ s/$matchForNew/$newNameRex/ee;		# evaluates two times be carefull
		print "mv " , "-v " ,"\"$file\" " ,"\"$destination$finalDestination\"\n";
	}	
}

print "\nyes or no? \n> ";
my $reply;
chomp($reply = <>);        # remove newline from $reply
if ($reply =~ m/^y/i) {    # Begins with 'y'
   print "positive!\n\n";
} else {
   print "negative!\n\n";
   exit;
}

undef @files;
undef $file;

@files = `$getFiles`;
foreach $file(@files){
	chop $file;
	if ($file =~ m/$selectionRex/i ) {
		$finalDestination = $file;
		$finalDestination =~ s/$matchForNew/$newNameRex/ee;
		system( "mv" , "-v" , "$file" , "$destination$finalDestination" );
	}
	
}
