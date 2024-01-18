planer(3) ma dodane wszystkie sensowne ograniczenia (poza:
          pracownik może być max w 3 zespołach jednocześnie (bo zespoły są usunięte, a z działami to nie ma sensu),
          sala może być jednocześnie zajęta przez 1 dział (bo tabela sale była usunięta i teraz ma tylko pojemność i nr),
          1 pracownik może być jednocześnie w 1 filii/dziale (bo to wynika z dodawania pracowników - 1 pracownik jest domyślnie przypisany do 1 filii/działu)).

dodane ograniczenia:
  spotkania:
    limit 2-15 osób
    dodawanie w godzinach 8:00-18:00
    1 pracownik może brać udział w 1 spotkaniu jednocześnie
    pracownik może być dodany (zaakceptować?) na spotkanie tylko w godzinach pracy

  sale:
    mogą być dodane w godzinach 8:00-18:00

  filie:
    nazwy muszą być unique

  działy:
    nazwy muszą być unique
    dział może mieć max 15 członków (oryginalnie zespół, ale zostały usunięte)

  grafik:
    dodawanie w godzinach 8:00-18:00
    1 pracownik może pracować <=40h tygodniowo
    do dodania bo **ważne** - sprawdzanie, czy dany pracownik ma grafik na dany dziań (żeby nie było np. dwóch poniedziałków, bo uznajemy to za planer tygodniowy)

  transakcje:
    ilość użytkowników nie może być większa niż pojemność sali + pracownik nie może zaakceptować spotkań z poza swojego grafiku(idk czy to to samo co w pracownikach)
    sala może być jednocześnie przypisana do 1 spotkania + lość użytkowników nie może być większa niż pojemność sali

do dodania: kopia zapasowa, logowanie? poziomy dostępu użytkowników

    
