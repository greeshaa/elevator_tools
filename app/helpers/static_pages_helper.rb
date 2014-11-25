# -*- encoding : utf-8 -*-
module StaticPagesHelper

	def messages #настройка вывода сообщений на основную панель
		messages = [
      {
        color: "primary",
         icon: "fa-clock-o",
        count: Inspection.where(next_inspection_at: Date.today..(Date.today + 7.day)).count,
         name: "ПТО",
         note: "в плане на 7 дн.",
         link: next_inspections_path
        },
      {
        color: "yellow",
         icon: "fa-exclamation-triangle",
        count: Inspection.where(active: true).where(rebuke: true).count,
         name: "ПТО",
         note: "с замечаниями",
         link: rebuke_inspections_path
      },
      {
        color: "yellow",
         icon: "fa-clock-o",
        count: Inspection.where(active: true).where(next_inspection_at: (Date.today - Time.now.to_a[7])..(Date.today - 1.day)).count,
         name: "ПТО",
         note: "просрочено",
         link: overdue_inspections_path
      },
      {
        color: "green",
         icon: "fa-check-circle-o",
        count: Inspection.where(created_at: (Date.today - 7.day)..Date.today + 1.day).count,
         name: "ПТО",
         note: "добавлено за 7 дн.",
         link: last_inspections_path
      },
      {
        color: "yellow",
         icon: "fa-exclamation-triangle",
        count: Lift.expiring_lifts.count,
         name: Russian.p(Lift.expiring_lifts.count, "лифт", "лифта", "лифтов"),
         note: "с истекающим сроком",
         link: overdue_lifts_path
      },
      {
        color: "red",
         icon: "fa-ban",
        count: Lift.overdue_lifts.count,
         name: Russian.p(Lift.overdue_lifts.count, "лифт", "лифта", "лифтов"),
         note: "с истекшим сроком",
         link: overdue_lifts_path
      },
      {
        color: "yellow",
         icon: "fa-exclamation-triangle",
        count: Contract.where(lifetime: Date.today..(Date.today + 3.month)).count,
         name: Russian.p(Contract.where(lifetime: Date.today..(Date.today + 3.month)).count, "договор", "договора", "договоров"),
         note: "с истекающим сроком",
         link: overdue_lifts_path
      },
      {
        color: "green",
         icon: "fa-check-circle-o",
        count: Contract.where(created_at: (Date.today - 7.day)..Date.today + 1.day).count,
         name: Russian.p(Contract.where(created_at: (Date.today - 7.day)..Date.today + 1.day).count, "договор", "договора", "договоров"),
         note: "с истекающим сроком",
         link: overdue_lifts_path
      }
    ]
	end
end
