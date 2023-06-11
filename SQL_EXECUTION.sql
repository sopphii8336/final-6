select * from book;
select * from ratings;
//尚未建立索引
select b.isbn,b.title,count(r.userid) from book b join ratings r on b.isbn=r.isbn where b.year='2005' group by b.isbn,b.title order by count(r.userid) desc;
//建立索引idx1
create index idx1 on book (year desc);
//建立idx1完成後查詢
select b.isbn,b.title,count(r.userid) from book b join ratings r on b.isbn=r.isbn where b.year='2005' group by b.isbn,b.title order by count(r.userid) desc;
//建立索引idx2
create index idx2 on book (isbn asc);
//建立idx2完成後查詢
select b.isbn,b.title,count(r.userid) from book b join ratings r on b.isbn=r.isbn where b.year='2005' group by b.isbn,b.title order by count(r.userid) desc;
//建立索引idx3
create index idx3 on ratings (isbn asc);
//建立idx3完成後查詢
select b.isbn,b.title,count(r.userid) from book b join ratings r on b.isbn=r.isbn where b.year='2005' group by b.isbn,b.title order by count(r.userid) desc;

//使用原先已經建立的idx3
select b.author,avg(r.rating),count(r.userid) from book b join ratings r on b.isbn=r.isbn group by b.author having count(r.userid)>10 order by avg(r.rating) desc;
//建立索引idx4
create index idx4 on book (isbn asc,author asc);
//建立idx4完成後查詢
select b.author,avg(r.rating),count(r.userid) from book b join ratings r on b.isbn=r.isbn group by b.author having count(r.userid)>10 order by avg(r.rating) desc;
//建立索引idx5
create index idx5 on ratings (isbn asc,rating asc);
//建立idx5完成後查詢
select b.author,avg(r.rating),count(r.userid) from book b join ratings r on b.isbn=r.isbn group by b.author having count(r.userid)>10 order by avg(r.rating) desc;
//強制使用idx5查詢
select /*+ index(ratings idx5) */b.author,avg(r.rating),count(r.userid) from book b join ratings r on b.isbn=r.isbn group by b.author having count(r.userid)>10 order by avg(r.rating) desc;
//建立索引idx6
create index idx6 on ratings (isbn asc,userid asc,rating asc);
//建立idx6完成後查詢
select b.author,avg(r.rating),count(r.userid) from book b join ratings r on b.isbn=r.isbn group by b.author having count(r.userid)>10 order by avg(r.rating) desc;
//建立索引idx7
create index idx7 on ratings (userid asc);
//建立idx7完成後查詢
select b.author,avg(r.rating),count(r.userid) from book b join ratings r on b.isbn=r.isbn group by b.author having count(r.userid)>10 order by avg(r.rating) desc;
//建立索引idx8
create index idx8 on ratings (isbn asc,userid asc);
//建立idx8完成後查詢
select b.author,avg(r.rating),count(r.userid) from book b join ratings r on b.isbn=r.isbn group by b.author having count(r.userid)>10 order by avg(r.rating) desc;
