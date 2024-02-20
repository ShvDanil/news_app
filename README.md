# News App

Новостное приложение на Flutter

Разработано мобильное приложение для просмотра новостных статей с поддержкой iOS и Android, используя Flutter и Dio библиотеки для работы с удаленным API.

API, которое используется для получения данных: https://newsapi.org/v2/everything?q=apple&apiKey=MY_API_KEY

Описание экранов:

Основной экран (Новостная лента):
- Отображение новостных статей с использованием данных, полученных из удаленного API (заголовок новости, название источника).
- Вертикальная прокрутка для просмотра новостной ленты.
- Ячейки с каждой новостью для перехода к дополнительному экрану выбранной новостной статьи и просмотра ее.

Дополнительный экран (Подробности новости):
- Отображение подробной информации по выбранной новостной статье (картинка, заголовок, описание, контент, автор, источник, дата публикации, кнопка подробнее в источнике).

Экран профиля:
- Заголовок "Профиль".
- Радиобаттоны с возможностью выбора темы: светлая, темная.

Технические требования:

- Использован Dio для выполнения запросов к API с использованием синтаксиса async/await.
- Использовано SharedPrefernces для сохранения выбранной темы приложения.
- Использован таб-бар для переходов между основным экраном новостей и экраном профиля.
- Использован json_serializable для модели статьи.
- Код отформатирован (dart format).
- Линтер подключен, и код не содержит warning-ов или error-ов.
- Использование flutter_lints с правильной настройкой и отсутствием ошибок/предупреждений/информаций.


### Скриншоты iOS

- ![1](./screenshots/1.png)
- ![2](./screenshots/2.png)
- ![3](./screenshots/3.png)
- ![4](./screenshots/4.png)
- ![5](./screenshots/5.png)
- ![6](./screenshots/6.png)
- ![7](./screenshots/7.png)

### Скриншоты Android

- ![8](./screenshots/8.png)
- ![9](./screenshots/9.png)
- ![10](./screenshots/10.png)
- ![11](./screenshots/11.png)
- ![12](./screenshots/12.png)
- ![13](./screenshots/13.png)
