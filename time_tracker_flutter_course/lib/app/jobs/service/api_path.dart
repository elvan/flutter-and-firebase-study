class APIPath {
  static String job(String uid, String jobId) => '/users/$uid/jobs/$jobId';

  static String jobList(String uid) => '/users/$uid/jobs';
}
