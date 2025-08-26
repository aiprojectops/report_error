-- RLS (Row Level Security) 활성화
ALTER TABLE error_reports ENABLE ROW LEVEL SECURITY;

-- 기존 정책 삭제 (있다면)
DROP POLICY IF EXISTS "Anyone can insert error reports" ON error_reports;
DROP POLICY IF EXISTS "Authenticated users can view error reports" ON error_reports;
DROP POLICY IF EXISTS "Authenticated users can update error reports" ON error_reports;
DROP POLICY IF EXISTS "Authenticated users can delete error reports" ON error_reports;

-- 정책 생성: 모든 사용자가 오류를 제출할 수 있음
CREATE POLICY "Anyone can insert error reports" ON error_reports
  FOR INSERT WITH CHECK (true);

-- 정책 생성: 인증된 사용자만 오류를 조회할 수 있음
CREATE POLICY "Authenticated users can view error reports" ON error_reports
  FOR SELECT USING (auth.role() = 'authenticated');

-- 정책 생성: 인증된 사용자만 오류를 업데이트할 수 있음
CREATE POLICY "Authenticated users can update error reports" ON error_reports
  FOR UPDATE USING (auth.role() = 'authenticated');

-- 정책 생성: 인증된 사용자만 오류를 삭제할 수 있음
CREATE POLICY "Authenticated users can delete error reports" ON error_reports
  FOR DELETE USING (auth.role() = 'authenticated');

-- 정책 확인
SELECT * FROM pg_policies WHERE tablename = 'error_reports';


-- 반드시 error_reports 정책에서 Enable RLS 설정이 되도록 확인!!!