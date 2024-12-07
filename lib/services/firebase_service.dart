import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/club.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 로그인
  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // 회원가입
  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 동아리 목록 가져오기
  Stream<List<Club>> getClubs() {
    return _firestore.collection('clubs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Club.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // 동아리 추가
  Future<void> addClub(Club club) async {
    await _firestore.collection('clubs').add(club.toFirestore());
  }

  // 동아리 일정 추가
  Future<void> addSchedule(String clubId, Map<String, dynamic> schedule) async {
    await _firestore
        .collection('clubs')
        .doc(clubId)
        .collection('schedules')
        .add(schedule);
  }

  // 동아리 일정 가져오기
  Stream<QuerySnapshot> getSchedules(String clubId) {
    return _firestore
        .collection('clubs')
        .doc(clubId)
        .collection('schedules')
        .snapshots();
  }
} 