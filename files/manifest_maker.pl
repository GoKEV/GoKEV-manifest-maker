#!/usr/bin/perl

$cm = ' , ';

if ( -d @ARGV[0]){
	$path = @ARGV[0];
	@allfiles = split(/\n/,`find $path -type f | sort`);
	$manifestfile = $path . "/.manifest";
}

open(MANIFEST, '>', $manifestfile ) or die "Can't open file: $!";


if (@ARGV[1] eq "vars"){
	print MANIFEST "manifest_files: \n";


}else{
	print MANIFEST "#" . prep_fields("FILE PATH") . $cm . prep_fields("RELATIVE PATH") . $cm . prep_fields("USER") . $cm . prep_fields("GROUP") . $cm . prep_fields("PERMISSIONS") ;
	print MANIFEST "\n" . prep_fields($path . "/.manifest") . $cm . prep_fields("root") . $cm . prep_fields("wheel") . $cm . prep_fields("644") ;
}

if (@ARGV[1] eq "vars"){
	## We do variable files for Ansible
	foreach $file(@allfiles){
		next if ($file =~ /\.manifest$/);		# Ignore existing .manifest files
		$count++;
		($user,$group,$perm) = split(/\./,`stat --printf="%U.%G.%a" "$file"`);
		($relfile = $file) =~ s/^$path\/(.*)$/$1/g;
		print MANIFEST <<ALLDONE;
  - fullpath: $file
    relative: $relfile
    user: $user
    group: $group
    perms: $perm 
ALLDONE

	}	
}else{
	## Default output is a simple CSV file
	foreach $file(@allfiles){
		next if ($file =~ /\.manifest$/);		# Ignore existing .manifest files
		$count++;
		($user,$group,$perm) = split(/\./,`stat --printf="%U.%G.%a" "$file"`);
		($relfile = $file) =~ s/^$path\/(.*)$/$1/g;
		print MANIFEST "\n" . prep_fields($file) . $cm . prep_fields($relfile) . $cm . prep_fields($user) . $cm . prep_fields($group) . $cm . prep_fields($perm) ;
	}	
}

print MANIFEST "\n# $count files #";
print "$count files in $path\n";




sub prep_fields{
	my $in = shift(@_);
	$in =~ s/^\s+|\s+$//g;
	my $out = '"' . $in . '"';
	return $out;

}

