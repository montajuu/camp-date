-- 영상캠프 날짜 정하기: Supabase SQL Editor에 통째로 붙여 넣고 Run 하세요.

create table if not exists public.votes (
  member     int primary key check (member between 0 and 9),
  dates      int[] not null default '{}'
             check (dates <@ array[1,2,3,4,5,6,7,8,9,10,11]),
  updated_at timestamptz not null default now()
);

alter table public.votes enable row level security;

-- 링크를 가진 누구나 응답을 보고, 자기 줄을 저장·수정할 수 있게 허용 (삭제는 불가)
drop policy if exists "anyone can read"   on public.votes;
drop policy if exists "anyone can insert" on public.votes;
drop policy if exists "anyone can update" on public.votes;

create policy "anyone can read"   on public.votes for select to anon using (true);
create policy "anyone can insert" on public.votes for insert to anon with check (true);
create policy "anyone can update" on public.votes for update to anon using (true) with check (true);

grant select, insert, update on public.votes to anon;
