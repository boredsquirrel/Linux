#!/usr/bin/env sh

echo """
             .',;::::;,'.
         .';:cccccccccccc:;,.
      .;cccccccccccccccccccccc;.
    .:cccccccccccccccccccccccccc:.             FEDORA KIONITE
  .;ccccccccccccc;.:dddl:.;ccccccc;.
 .:ccccccccccccc;OWMKOOXMWd;ccccccc:.          SETUP SCRIPT
.:ccccccccccccc;KMMc;cc;xMMc:ccccccc:.
,cccccccccccccc;MMM.;cc;;WW::cccccccc,
:cccccccccccccc;MMM.;cccccccccccccccc:
:ccccccc;oxOOOo;MMM0OOk.;cccccccccccc:
cccccc:0MMKxdd:;MMMkddc.;cccccccccccc; 
ccccc:XM0';cccc;MMM.;cccccccccccccccc'
ccccc;MMo;ccccc;MMW.;ccccccccccccccc;
ccccc;0MNc.ccc.xMMd:ccccccccccccccc;
cccccc;dNMWXXXWM0::cccccccccccccc:,
cccccccc;.:odl:.;cccccccccccccc:,.
:cccccccccccccccccccccccccccc:'.
.:cccccccccccccccccccccc:;,..
  '::cccccccccccccc::;,.


"""
mkdir ~/SETUP
cd ~/SETUP
wget https://github.com/trytomakeyouprivate/Linux-help/blob/main/Fedora-Kionite-setupscript-part1.sh
wget https://github.com/trytomakeyouprivate/Linux-help/blob/main/Fedora-Kionite-setupscript-part2.sh

# add a few input loops downloading the

Are you on an NVIDIA machine?
- Do you want the proprietary driver?

Do you want intel graphics drivers?

Do you want media codecs?

Do you want Waydroid?

...
