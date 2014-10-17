# -*- encoding : utf-8 -*-
module StaticPagesHelper

	def messages #настройка вывода сообщений на основную панель
		messages = [
      {
        color: "primary",
         icon: "fa-clock-o",
        count: Inspection.where(next_inspection_at: Date.today..(Date.today + 7.day)).count,
         name: "ПТО",
         note: "в плане на след. 7 дн.",
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
         note: "добавлено за послед. 7 дн.",
         link: overdue_inspections_path
      },
      {
        color: "red",
         icon: "fa-ban",
        count: Lift.overdue_lifts.count,
         name: Russian.p(Lift.overdue_lifts.count, "лифт", "лифта", "лифтов"),
         note: "с истекшим сроком экспл-и",
         link: overdue_lifts_path
      }
    ]
	end
end
