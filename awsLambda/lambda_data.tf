
data "archive_file" "dummy" {
  type = "zip"
  output_path = "${path.module}/lambda-java-src-1.0-SNAPSHOT.jar"

  source {
    content = "dummycontent"
    filename = "dummy.txt"
  }
}
