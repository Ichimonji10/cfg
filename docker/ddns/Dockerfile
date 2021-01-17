FROM jobber
LABEL maintainer="jerebear@protonmail.com"

# Temporarily become root to perform a privileged operation (installing bash), then switch back to
# the user specified by the parent image.
USER root
RUN ["apk", "add", "--no-cache", "bash", "curl"]
USER $USERID

COPY --chown=$USERID ["jobber", "/home/jobberuser/.jobber"]
