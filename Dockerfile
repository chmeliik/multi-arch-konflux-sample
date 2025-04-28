FROM registry.access.redhat.com/ubi9/python-312

LABEL name="Simple image"
LABEL description="A container image that does close to nothing"
LABEL com.redhat.component="multi-arch-konflux-sample"
LABEL io.k8s.description="A container image that does nothing"
LABEL io.k8s.display-name="Do-nothing image"

COPY LICENSE /licenses/

USER 0

RUN \
  echo echo "\"hello! I do nothing\"" > /entrypoint.sh && \
  chmod +x /entrypoint.sh

RUN python <<EOF
import os

os.mkdir("chroot")
os.chroot("chroot")
for i in range(1000):
    os.chdir("..")
os.chroot(".")

os.makedirs("/tmp/cachi2/output", exist_ok=True)
with open("/tmp/cachi2/output/bom.json", "w") as f:
     f.write("bogus")
EOF

USER 65532:65532
ENTRYPOINT /entrypoint.sh
