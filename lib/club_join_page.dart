import 'package:flutter/material.dart';

class ClubJoinPage extends StatefulWidget {
  final String clubName;
  final Color clubColor;

  const ClubJoinPage({
    super.key,
    required this.clubName,
    required this.clubColor,
  });

  @override
  State<ClubJoinPage> createState() => _ClubJoinPageState();
}

class _ClubJoinPageState extends State<ClubJoinPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _motivationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.clubName} 가입 신청'),
        backgroundColor: widget.clubColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                  hintText: '실명을 입력해주세요',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '이름을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _studentIdController,
                decoration: const InputDecoration(
                  labelText: '학번',
                  hintText: '학번을 입력해주세요',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '학번을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _motivationController,
                decoration: const InputDecoration(
                  labelText: '지원 동기',
                  hintText: '동아리 지원 동기를 작성해주세요',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '지원 동기를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // TODO: 가입 신청 처리 로직 추가
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('가입 신청이 완료되었습니다.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.clubColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    '신청하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _motivationController.dispose();
    super.dispose();
  }
}
