FROM gitlab/gitlab-ce
LABEL MAINTAINER='Samuel Bernard "samuel.bernard@gmail.com"'

RUN \
  apt-get update && \
  apt-get -y install sudo curl tar tzdata && \
  curl -L https://www.getchef.com/chef/install.sh | bash && \
  apt-get clean autoclean

RUN sed -i "s/# gitlab_rails\['initial_root_password'\] = \"password\"/gitlab_rails\['initial_root_password'\] = \"P@ssw0rd\"/g" \
  /opt/gitlab/etc/gitlab.rb.template

RUN for t in runners_registration_token health_check_access_token; do \
  sed -i "s/$t character varying/$t character varying DEFAULT \'1234567890\'::character varying/g" \
  /opt/gitlab/embedded/service/gitlab-rails/db/structure.sql; done

RUN sed -i "s/# gitlab_rails\['initial_shared_runners_registration_token'\] = \"token\"/gitlab_rails\['initial_shared_runners_registration_token'\] = \"1234567890\"/g" \
  /opt/gitlab/etc/gitlab.rb.template

RUN sed -i "s/# gitlab_rails\['monitoring_whitelist'\] = \['127.0.0.0\/8'\, '::1\/128'\]/gitlab_rails\['monitoring_whitelist'\] = \['0.0.0.0\/0', '::\/0'\]/g" \
  /opt/gitlab/etc/gitlab.rb.template
