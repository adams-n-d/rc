export PATH="$PATH:/Users/nda/Downloads/mvn/apache-maven-3.2.5/bin:/opt/local/lib/mysql56/bin"

set -o vi

# cd also does an ls
# cdd behaves like normal cd
function cdHelper () {
    builtin cd "$@" && ls
}
alias cd='cdHelper "$@"'
alias cdd='builtin cd "$@"'


alias lst='ls -alt $@'

#fuck more
function manHelper() {
    `which man` "$@" | less
}


alias more='less "$@"'
alias man='manHelper "$@"'

alias fd='find . -name "$@"'

alias grin='grep -rin "$@" *'
alias grini='grep -rinI "$@" *'


alias sls='screen -ls'
alias sr='screen -r "$@"'

alias ZZ='exit'

# Proxy lab utilities


function goHelper() {
    #{ echo "su - labcore"; sleep 2; } | ssh "$@" -t "bash -c 'bash --init-file /export/home/labcore/.util'"
    
    #{ echo "bash --init-file /export/home/labcore/.util"; sleep 2; } | ssh "$@" -t 'su - labcore'
    #ssh "$@" -t "su - labcore << bash -c 'bash --init-file /export/home/labcore/.util' ;" 
    #ssh "$@" -t "su - labcore"

    # This works.
    ssh "$@" -t "bash -c 'bash --init-file .util'"



    # All of these suck.
    #ssh "$@" -t "bash -l -c 'bash -c `if [ -f ~/.util ]; then echo . util;else echo ls;fi;`'"
    #ssh "$@" -t ". .util"
    #ssh "$@" -t echo "bash -l -c '. .util'"
    #ssh "$@" -t "bash -c 'bash -l; if [ -f .util ]; then source .util;fi;'"
    #ssh "$@" -t "bash -c 'bash -l -c \"if [ -f .util ]; then source .util;fi;\"'"
    #ssh "$@" -t "bash -c 'bash --init-file .util -l -i'"
    #ssh "$@" -t "bash -c 'echo ls | bash -l'"
}


alias go='goHelper "$@"'

function gosk() {
    ssh sk -t "bash -c 'bash --init-file .util'"
}


# Cat the manifest file from a jar.
#alias jarmf='unzip -q -c "$@" "META-INF\/MANIFEST.MF"'
function jarmf() {
    unzip -q -c "$@" META-INF/MANIFEST.MF
}

# Copy a file to pldm lab
function pldmcp() {
    LC_HOME=/Users/nda/code/pldm/
    #scp
}

# We sometimes don't have direct user access.
function lcp() {
    file="$1"
    remotehost="$2"
    #proxyuser="v50032"
    #enduser="labcore"
    #echo "file=${file} remotehost=${remotehost} proxyuser=${proxyuser} \
#enduser=${enduser}"

    scp $file ${remotehost}:/tmp/

    # Commands to execute
    #commands=
    

}


# Shortcuts to common working dirs

alias al='cd ~/code/afterlife'
alias alx='cd ~/code/afterlife/src/web/src/conf'
alias alf='cd ~/code/afterlife/src/web/ftl/afterlife'
alias alm='cd ~/code/afterlife/src/web/src/plabs/web'

alias soap='cd ~/adapter/csi/server/src/adapter/csi/server'
#soap home
alias soaph='cd ~/adapter/csi/server'
#soap client
alias soapc='cd ~/rss/apex_branch/csi/interface'
#csi lib
alias csil='cd ~/plabs-csi/src/main/java/plabs/csi'
#plabs-common lib
alias coml='cd ~/plabs-common/src/main/java/plabs/common'

alias pywx='cd /Users/nda/code/wx/demos'

export HISTFILESIZE=999999
export HISTSIZE=999999
alias py='python'

#make 'screen' show the right prompt
PS1="\h:\W \u\$ "

#allow 'rm !(file)'
shopt -s extglob

export CATALINA_HOME=/Users/nda/code/build/apache-tomcat-6.0.41-src/output/build
export CATALINA_BASE=/Users/nda/code/rss/apex_branch/roamersel/apache-tomcat-5.5.17
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home



# Kill a process by grep.
function gkill()
{
    kill `ps -ef | grep "$@" | grep -v grep | awk '{ print $2 }'`
}

# Show processes by grep.
function gps()
{
    ps -ef | grep "$@"
}


# Assign today's log filenames to variables.
date=`date +%Y%m%d`
tx=dmproxy${LC_ID}.${date}
msg=dmproxy-msg${LC_ID}.${date}
main=dmproxy-main${LC_ID}.${date}

# cd up n directories.
function up()
{
    i="$@"
    x=0
    pth=""
    while [ $x -lt $i ]
    do
        pth=${pth}../
        let x=$x+1
    done;
    builtin cd $pth
    echo "Going up to `pwd`"
    ls
}

function ud06get()
{
    scp ud06:/data/jenkins/jenkins/workspace/LCI_PLDM_rcs-branch/lib/*"$1"* ./
}

function put()
{
    scp ${1} ${2}:/tmp/
}




# source ~/.loadjava8
