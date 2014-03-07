Pentaho 5 CE com PostgreSQL 9.3
==========================

Este repositório agrega todos os arquivos necessários para configuração do Pentaho CE, versão 5.0.1, com PostgreSQL 9.3. 
#### Ambiente testado ####
<pre>
$ cat /etc/system-release
Amazon Linux AMI release 2013.09

$ uname -a
Linux 3.4.76-65.111.amzn1.x86_64 #1 SMP Tue Jan 14 21:06:49 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

$ java -version
java version "1.7.0_51"

$ psql --version
psql (PostgreSQL) 9.3.3
</pre>

Procedimento
--

###Instalação do PostgreSQL Local###

 * Referência: https://wiki.postgresql.org/wiki/YUM_Installation
 * Configuração - pg_hba.conf
<pre>
  sudo vim /var/lib/pgsql/9.3/data/pg_hba.conf
  #Adicionar
  host    all             all             0.0.0.0/0               md5
</pre>

 * Configuração - postgresql.conf
<pre>
  $ sudo vim /var/lib/pgsql/9.3/data/postgresql.conf
  # Atualizar listen_addresses
  listen_addresses = '*'
</pre>

### Criar usuário ###
<pre>
sudo useradd -s /bin/bash -d /opt/pentaho pentaho
</pre>

###Baixar a última versão CE estável###
 * http://community.pentaho.com/
 * https://sourceforge.net/projects/pentaho/files/Business%20Intelligence%20Server/5.0.1-stable/

<pre>
sudo su - pentaho
wget 'http://downloads.sourceforge.net/project/pentaho/Business%20Intelligence%20Server/5.0.1-stable/biserver-ce-5.0.1-stable.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpentaho%2Ffiles%2FBusiness%2520Intelligence%2520Server%2F5.0.1-stable%2F&ts=1394208071&use_mirror=ufpr' -O biserver-ce-5.0.1-stable.zip
</pre>

### Descompactar Pentaho ###
<pre>
unzip biserver-ce-5.0.1-stable.zip
</pre>

### Inicializar repositório ###
 * Referência: http://infocenter.pentaho.com/help/index.jsp?topic=%2Finstall_manual%2Ftask_set_environment.html

### Baixar configurações predefinidas ###
<pre>
   git clone https://github.com/wmarinho/pentaho5-config-postgresql.git
</pre>

### Aplicar configurações ###

<pre>
  cp -r pentaho5-config-postgresql/biserver-ce .
</pre>

### Inicializar repositório ###

<pre>
  cd pentaho5-config-postgresql/biserver-ce/data/postgresql
  psql -U postgres -h localhost < create_quartz_postgresql.sql
  psql -U postgres -h localhost < create_repository_postgresql.sql
  psql -U postgres -h localhost < create_jcr_postgresql.sql
</pre>

Usuários e senhas estão predefinidos nos arquivos *.sql. 

Para utilizar em produção, é recomendável a alteração em todos os arquivos. Segue um comando simples que pode ajudar

<pre>
  cd pentaho5-config-postgresql
  grep -Rn '!jcrUs3r#' *
  grep -Rn '!h1bUs3r#' *
  grep -Rn '!p3nt4h0Us3r#' *
</pre>
