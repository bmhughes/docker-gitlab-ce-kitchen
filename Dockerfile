FROM gitlab/gitlab-ce
MAINTAINER Samuel Bernard "samuel.bernard@gmail.com"

# Let's run stuff
RUN \
  apt-get update && \
  apt-get -y install sudo curl tar && \
  sed -i 's/"runners_registration_token"/"runners_registration_token", default: "1234567890"/g' /opt/gitlab/embedded/service/gitlab-rails/db/schema.rb && \
  curl -L https://www.getchef.com/chef/install.sh | bash && \
  ln -s /opt/chef/bin/chef-client /bin/chef-client
