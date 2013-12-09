#!/usr/bin/perl -ws
#
$host = $ARGV[0];

$input = $ARGV[1];
open (IN, "<$input") || die $!;

$output = $ARGV[2];
open (OUT, ">$output") || die $!;

while(<IN>){
  # находим нужные строки
  if( 
  ( 
	/failed/i  || 
	/WARNING:\sNMP/ || 
	/nmp_ThrottleLogForDevice:/ || 
	/Waiting\sfor\stimed\sout/ || 
	/iscsi_vmk/ || 
	/because\ its\ ramdisk\ \(tmp\)\ is\ full/ 
  ) && 
	!/UserObj/ && 
	!/H:0x0 D:0x2 P:0x0/ && 
	!/No\ free\ memory\ for\ file\ data/ && 
	!/Transient\ file\ system\ condition,\ suggest\ retry/ 
  )
  {
	# уникальная фильтрация по хостам
	if    ($host eq 'esx-11' || $host eq 'esx-11.at-consulting.ru'){print OUT if(!/mpx.vmhba0:C3:T0:L0/);}
	elsif ($host eq 'esx-09' || $host eq 'esx-09.at-consulting.ru'){print OUT if(!/mpx.vmhba2:C3:T0:L0/);} 
	else  {print OUT;}

  };

}

close OUT;
close IN;
